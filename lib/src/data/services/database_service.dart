import 'package:isar/isar.dart';
import '../model/dream.dart';

class DatabaseService {
  final Isar isar;

  DatabaseService(this.isar);

  Future<void> saveDream(Dream dream) async {
    await isar.writeTxn(() async {
      await isar.dreams.put(dream);
    });
  }

  Future<List<Dream>> getAllDreams() async {
    return await isar.dreams.where().sortByDateDesc().findAll();
  }

  Future<void> deleteDream(Id id) async {
    await isar.writeTxn(() async {
      await isar.dreams.delete(id);
    });
  }

  Stream<List<Dream>> listenToDreams() {
    return isar.dreams.where().sortByDateDesc().watch(fireImmediately: true);
  }

  Future<List<Dream>> searchDreams(String term) async {
    return await isar.dreams
        .filter()
        .titleContains(term, caseSensitive: false)
        .or()
        .contentContains(term, caseSensitive: false)
        .findAll();
  }
}