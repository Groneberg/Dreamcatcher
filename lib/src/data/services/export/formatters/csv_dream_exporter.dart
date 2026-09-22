import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';

import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/export/formatters/dream_exporter.dart';

class CsvDreamExporter implements DreamExporter {
  @override
  String get fileExtension => 'csv';

  @override
  String get mimeType => 'text/csv';

  @override
  Future<Uint8List> generateData(List<Dream> dreams) async {
    final List<List<dynamic>> rows = [
      // CSV Header
      ['id', 'date', 'title', 'content', 'clarity_score', 'tags'],
    ];

    for (final dream in dreams) {
      rows.add([
        dream.id,
        dream.date.toIso8601String(),
        dream.title ?? '',
        dream.content,
        dream.clarityScore,
        dream.tags.join('; '),
      ]);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    return Uint8List.fromList(utf8.encode(csvString));
  }
}