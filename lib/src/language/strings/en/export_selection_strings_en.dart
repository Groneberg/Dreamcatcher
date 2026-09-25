import '../export_selection_strings.dart';

class ExportSelectionStringsEn implements ExportSelectionStrings {
  @override
  String get sheetTitle => 'CHOOSE EXPORT FORMAT';

  @override
  String get jsonTitle => 'JSON Backup';

  @override
  String get jsonDescription => 'Full uncompressed archive for restoration';

  @override
  String get pdfTitle => 'PDF Document';

  @override
  String get pdfDescription => 'Formatted reading & therapy report';

  @override
  String get markdownTitle => 'Markdown Archive';

  @override
  String get markdownDescription => 'Compatible with Obsidian, Logseq & Bear';

  @override
  String get csvTitle => 'CSV Sheet';

  @override
  String get csvDescription => 'For spreadsheets and metric analysis';

  @override
  String get errorEmptyDreams => 'No memories to export yet. 🌌';

  @override
  String get errorExportFailed => 'Could not export memories. Please try again.';
}
