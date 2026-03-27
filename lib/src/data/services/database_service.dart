import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../model/dream.dart';
import '../../../objectbox.g.dart';

class DatabaseService {
  late final Store store;
  late final Box<Dream> dreamBox;

  DatabaseService._(this.store) {
    dreamBox = Box<Dream>(store);
  }

  static Future<DatabaseService> init() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docsDir.path, "objectbox_dreams");
    
    final store = await openStore(directory: dbPath);
    return DatabaseService._(store);
  }

  Future<void> saveDream(Dream dream) async {
    dreamBox.put(dream);
  }

  Future<void> deleteDream(int id) async {
    dreamBox.remove(id);
  }

  Stream<List<Dream>> listenToDreams() {
    return watchFilteredDreams('');
  }

Stream<List<Dream>> watchFilteredDreams(String query) {
    if (query.isEmpty) {
      return dreamBox
          .query()
          .order(Dream_.date, flags: Order.descending)
          .watch(triggerImmediately: true) // <-- Hier korrigiert
          .map((q) {
            final results = q.find();
            print("📦 ObjectBox liefert ${results.length} Träume (ohne Filter)");
            return results;
          });
    }

    final queryBuilder = dreamBox.query(
      Dream_.title.contains(query, caseSensitive: false)
      .or(Dream_.content.contains(query, caseSensitive: false))
    )..order(Dream_.date, flags: Order.descending);

    return queryBuilder.watch(triggerImmediately: true).map((q) { // <-- Hier korrigiert
      final results = q.find();
      print("📦 ObjectBox liefert ${results.length} Träume (mit Filter)");
      return results;
    });
  }

  Future<List<Dream>> getAllDreams() async {
    return dreamBox.getAll();
  }

  Future<List<String>> getAllUniqueTags() async {
    final dreams = dreamBox.getAll();
    return dreams.expand((d) => d.tags).toSet().toList();
  }

  void close() {
    store.close();
  }
}