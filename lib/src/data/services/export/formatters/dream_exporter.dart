import 'dart:typed_data';

import 'package:dreamcatcher/src/data/model/dream.dart';

abstract class DreamExporter {
  String get fileExtension;
  String get mimeType;

  Future<Uint8List> generateData(List<Dream> dreams);
}
