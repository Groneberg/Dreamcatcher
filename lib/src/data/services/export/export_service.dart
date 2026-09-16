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
    final dreams = await dbService.getAllDreams();
    if (dreams.isEmpty) {
      throw Exception('No dreams to export.');
    }

    final data = await exporter.generateData(dreams);
    final tempDir = await getTemporaryDirectory();
    final dateStr = DateTime.now().toIso8601String().split('T')[0];
    final fileName = 'dreamcatcher_export_$dateStr.${exporter.fileExtension}';
    final file = File('${tempDir.path}/$fileName');

    await file.writeAsBytes(data);

    await Share.shareXFiles(
      [XFile(file.path, mimeType: exporter.mimeType)],
      subject: 'DreamCatcher Backup',
      sharePositionOrigin: sharePositionOrigin,
    );
  }
}
