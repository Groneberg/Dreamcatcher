import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/data/services/import/import_result.dart';

class ImportService {
  final DatabaseService dbService;

  ImportService(this.dbService);

  Future<ImportResult> pickAndImportJson() async {
    try {
      dev.log('📂 [Import] Opening document picker...', name: 'ImportService');

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) {
        dev.log('↩️ [Import] User cancelled file selection.', name: 'ImportService');
        return const ImportResult.cancelled();
      }

      final file = File(result.files.single.path!);
      final rawContent = await file.readAsString();

      dev.log(
        '📄 [Import] Read file (${rawContent.length} chars). Parsing JSON...',
        name: 'ImportService',
      );

      final Map<String, dynamic> jsonMap = jsonDecode(rawContent);

      if (!jsonMap.containsKey('entries') || jsonMap['entries'] is! List) {
        throw const FormatException(
          'Malformed backup: missing "entries" list.',
        );
      }

      final rawEntries = jsonMap['entries'] as List<dynamic>;
      final List<Dream> dreamsToSave = [];
      int skipped = 0;

      for (final entry in rawEntries) {
        if (entry is Map<String, dynamic>) {
          // preserveId = false garantiert neue IDs und verhindert Überschreiben lokaler Einträge
          final dream = Dream.fromJson(entry, preserveId: false);
          if (dream.content.trim().isNotEmpty) {
            dreamsToSave.add(dream);
          } else {
            skipped++;
          }
        } else {
          skipped++;
        }
      }

      if (dreamsToSave.isEmpty) {
        return ImportResult.failure(
          'No valid dream memories found in backup.',
        );
      }

      for (final dream in dreamsToSave) {
        await dbService.saveDream(dream);
      }

      dev.log(
        '✅ [Import] Successfully restored ${dreamsToSave.length} memories (Skipped: $skipped).',
        name: 'ImportService',
      );

      return ImportResult.success(
        importedCount: dreamsToSave.length,
        skippedCount: skipped,
      );
    } catch (e, stack) {
      dev.log(
        '❌ [Import] Import failed: $e\n$stack',
        name: 'ImportService',
      );
      return ImportResult.failure(
        e is FormatException ? 'Invalid JSON format.' : e.toString(),
      );
    }
  }
}