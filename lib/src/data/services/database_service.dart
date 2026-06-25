import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../model/dream.dart';
import '../../../objectbox.g.dart';

class DatabaseService {
  late final Store _store;
  late final Box<Dream> _dreamBox;

  DatabaseService(this._store) {
    _dreamBox = _store.box<Dream>();
  }

  static Future<DatabaseService> init() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docsDir.path, "objectbox_dreams");

    final store = await openStore(directory: dbPath);
    return DatabaseService(store);
  }

  Future<void> saveDream(Dream dream) async {
    _dreamBox.put(dream);
  }

  Future<void> deleteDream(int id) async {
    _dreamBox.remove(id);
    log("Dream with id $id deleted from database.");
    log("Lösche Traum mit ID: $id");
  }

  Stream<List<Dream>> listenToDreams() {
    return watchFilteredDreams('');
  }

  Stream<List<Dream>> searchDreams(String query) {
    if (query.isEmpty) {
      return listenToDreams();
    }

    final queryBuilder = _dreamBox.query(
      Dream_.title
          .contains(query, caseSensitive: false)
          .or(Dream_.content.contains(query, caseSensitive: false)),
    )..order(Dream_.date, flags: Order.descending);

    return queryBuilder.watch(triggerImmediately: true).map((q) => q.find());
  }

  Stream<List<Dream>> watchFilteredDreams(String query) {
    if (query.isEmpty) {
      return _dreamBox
          .query()
          .order(Dream_.date, flags: Order.descending)
          .watch(triggerImmediately: true)
          .map((q) => q.find());
    }

    final queryBuilder = _dreamBox.query(
      Dream_.title
          .contains(query, caseSensitive: false)
          .or(Dream_.content.contains(query, caseSensitive: false)),
    )..order(Dream_.date, flags: Order.descending);

    return queryBuilder.watch(triggerImmediately: true).map((q) => q.find());
  }

  List<String> getAllUniqueTags() {
    final dreams = _dreamBox.getAll();
    final tagsSet = <String>{};
    for (final dream in dreams) {
      tagsSet.addAll(dream.tags);
    }
    return tagsSet.toList()..sort();
  }

  Stream<List<Dream>> watchCombinedDreams({
    String? textQuery,
    List<String>? activeTags,
    DateTimeRange? selectedRange,
  }) {
    var queryBuilder = _dreamBox.query();

    if (textQuery != null && textQuery.trim().isNotEmpty) {
      final sanitizedQuery = textQuery.trim();
      queryBuilder = _dreamBox.query(
        Dream_.title
            .contains(sanitizedQuery, caseSensitive: false)
            .or(Dream_.content.contains(sanitizedQuery, caseSensitive: false)),
      );
    }

    if (selectedRange != null) {
      final startTimestamp = DateTime(
        selectedRange.start.year,
        selectedRange.start.month,
        selectedRange.start.day,
      ).millisecondsSinceEpoch;
      final endTimestamp = DateTime(
        selectedRange.end.year,
        selectedRange.end.month,
        selectedRange.end.day,
      )
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1))
          .millisecondsSinceEpoch;

      queryBuilder = _dreamBox.query(
        Dream_.date.between(startTimestamp, endTimestamp),
      );

      if (textQuery != null && textQuery.trim().isNotEmpty) {
        final sanitizedQuery = textQuery.trim();
        queryBuilder = _dreamBox.query(
          Dream_.date
              .between(startTimestamp, endTimestamp)
              .and(Dream_.title
                  .contains(sanitizedQuery, caseSensitive: false)
                  .or(Dream_.content.contains(sanitizedQuery, caseSensitive: false))),
        );
      }
    }

    queryBuilder.order(Dream_.date, flags: Order.descending);

    return queryBuilder.watch(triggerImmediately: true).map((q) {
      final results = q.find();
      if (activeTags == null || activeTags.isEmpty) return results;

      return results.where((dream) {
        if (dream.tags.isEmpty) return false;
        return activeTags.every((tag) => dream.tags.contains(tag));
      }).toList();
    });
  }

  Future<List<Dream>> getAllDreams() async {
    return _dreamBox.getAll();
  }

  Stream<Dream?> listenToDreamById(int id) {
    return _dreamBox
        .query(Dream_.id.equals(id))
        .watch(triggerImmediately: true)
        .map((query) => query.findFirst());
  }

  void dispose() {
    _store.close();
  }
}
