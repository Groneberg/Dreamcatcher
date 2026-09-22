import 'dart:convert';
import 'dart:typed_data';

import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/export/formatters/dream_exporter.dart';

class MarkdownDreamExporter implements DreamExporter {
  @override
  String get fileExtension => 'md';

  @override
  String get mimeType => 'text/markdown';

  @override
  Future<Uint8List> generateData(List<Dream> dreams) async {
    final buffer = StringBuffer();

    buffer.writeln('# DreamCatcher Journal Archive');
    buffer.writeln('Exported on: ${DateTime.now().toIso8601String()}\n');
    buffer.writeln('---\n');

    for (final dream in dreams) {
      buffer.writeln('---');
      buffer.writeln('id: ${dream.id}');
      buffer.writeln('date: ${dream.date.toIso8601String()}');
      buffer.writeln('clarity: ${dream.clarityScore}');
      if (dream.tags.isNotEmpty) {
        buffer.writeln('tags:');
        for (final tag in dream.tags) {
          buffer.writeln('  - $tag');
        }
      } else {
        buffer.writeln('tags: []');
      }
      buffer.writeln('---');
      buffer.writeln();

      final title = dream.title?.trim().isNotEmpty == true
          ? dream.title!.trim()
          : 'Untitled Memory';
      buffer.writeln('## $title\n');
      buffer.writeln(dream.content.trim());
      buffer.writeln('\n---\n');
    }

    return Uint8List.fromList(utf8.encode(buffer.toString()));
  }
}