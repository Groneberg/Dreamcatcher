import '../export_selection_strings.dart';

class ExportSelectionStringsFr implements ExportSelectionStrings {
  @override
  String get sheetTitle => 'CHOISIR LE FORMAT D’EXPORT';

  @override
  String get jsonTitle => 'Sauvegarde JSON';

  @override
  String get jsonDescription =>
      'Archive complète non compressée pour restauration';

  @override
  String get pdfTitle => 'Document PDF';

  @override
  String get pdfDescription => 'Rapport formaté pour lecture et thérapie';

  @override
  String get markdownTitle => 'Archive Markdown';

  @override
  String get markdownDescription => 'Compatible avec Obsidian, Logseq et Bear';

  @override
  String get csvTitle => 'Feuille CSV';

  @override
  String get csvDescription => 'Pour tableurs et analyses de données';

  @override
  String get errorEmptyDreams => 'Aucun souvenir à exporter pour le moment. 🌌';

  @override
  String get errorExportFailed =>
      'Impossible d’exporter les souvenirs. Merci de réessayer.';
}
