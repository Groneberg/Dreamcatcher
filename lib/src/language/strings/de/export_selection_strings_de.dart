import '../export_selection_strings.dart';

class ExportSelectionStringsDe implements ExportSelectionStrings {
  @override
  String get sheetTitle => 'EXPORTFORMAT AUSWÄHLEN';

  @override
  String get jsonTitle => 'JSON-Backup';

  @override
  String get jsonDescription => 'Komplettes unkomprimiertes Archiv zur Wiederherstellung';

  @override
  String get pdfTitle => 'PDF-Dokument';

  @override
  String get pdfDescription => 'Formatierte Lese- und Therapieübersicht';

  @override
  String get markdownTitle => 'Markdown-Archiv';

  @override
  String get markdownDescription => 'Kompatibel mit Obsidian, Logseq und Bear';

  @override
  String get csvTitle => 'CSV-Tabelle';

  @override
  String get csvDescription => 'Für Tabellenkalkulationen und Metrikanalysen';

  @override
  String get errorEmptyDreams => 'Noch keine Erinnerungen zum Exportieren. 🌌';

  @override
  String get errorExportFailed => 'Die Erinnerungen konnten nicht exportiert werden. Bitte versuche es erneut.';
}
