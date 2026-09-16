import 'dart:convert';
import 'dart:typed_data';

import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/export/formatters/dream_exporter.dart';

class JsonDreamExporter implements DreamExporter {
  @override
  String get fileExtension => 'json';

  @override
  String get mimeType => 'application/json';

  @override
  Future<Uint8List> generateData(List<Dream> dreams) async {
    final exportMap = {
      'schema_version': 1,
      'app_version': '1.0.0',
      'exported_at': DateTime.now().toIso8601String(),
      'dream_count': dreams.length,
      'entries': dreams.map((d) => d.toJson()).toList(),
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(exportMap);
    return Uint8List.fromList(utf8.encode(jsonString));
  }
}
