import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/data/services/export/formatters/dream_exporter.dart';

class ExportService {
  final DatabaseService dbService;

  ExportService(this.dbService);

  Future<void> exportDreams({
    required DreamExporter exporter,
    Rect? sharePositionOrigin,
  }) async {
    dev.log('🚀 [Export] Starting export pipeline...', name: 'ExportService');

    final dreams = await dbService.getAllDreams();
    dev.log(
      '📦 [Export] Loaded ${dreams.length} dream(s) from database.',
      name: 'ExportService',
    );

    if (dreams.isEmpty) {
      dev.log('⚠️ [Export] Aborted: No dreams found.', name: 'ExportService');
      throw Exception('No dreams to export.');
    }

    final data = await exporter.generateData(dreams);
    dev.log(
      '📊 [Export] Generated payload size: ${data.lengthInBytes} bytes.',
      name: 'ExportService',
    );

    try {
      final previewString = utf8.decode(data);
      dev.log(
        '📜 [Export] Payload Content:\n$previewString',
        name: 'ExportService',
      );
    } catch (_) {
      dev.log(
        'ℹ️ [Export] Binary payload generated (non-UTF8 or raw format).',
        name: 'ExportService',
      );
    }

    final tempDir = await getTemporaryDirectory();
    final dateStr = DateTime.now().toIso8601String().split('T')[0];
    final fileName = 'dreamcatcher_export_$dateStr.${exporter.fileExtension}';
    final file = File('${tempDir.path}/$fileName');

    await file.writeAsBytes(data);
    dev.log('💾 [Export] File written to: ${file.path}', name: 'ExportService');
    dev.log('📁 [Export] File exists: ${await file.exists()}', name: 'ExportService');

    dev.log('📤 [Export] Triggering native share sheet...', name: 'ExportService');
    await Share.shareXFiles(
      [XFile(file.path, mimeType: exporter.mimeType)],
      subject: 'DreamCatcher Backup',
      sharePositionOrigin: sharePositionOrigin,
    );
    dev.log('✅ [Export] Share sheet completed.', name: 'ExportService');
  }
}