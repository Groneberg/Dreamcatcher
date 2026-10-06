import '../export_selection_strings.dart';

class ExportSelectionStringsEs implements ExportSelectionStrings {
  @override
  String get sheetTitle => 'ELEGIR FORMATO DE EXPORTACIÓN';

  @override
  String get jsonTitle => 'Copia de seguridad JSON';

  @override
  String get jsonDescription =>
      'Archivo completo sin comprimir para restauración';

  @override
  String get pdfTitle => 'Documento PDF';

  @override
  String get pdfDescription => 'Informe formateado para lectura y terapia';

  @override
  String get markdownTitle => 'Archivo Markdown';

  @override
  String get markdownDescription => 'Compatible con Obsidian, Logseq y Bear';

  @override
  String get csvTitle => 'Hoja CSV';

  @override
  String get csvDescription => 'Para hojas de cálculo y análisis de métricas';

  @override
  String get errorEmptyDreams => 'Aún no hay recuerdos para exportar. 🌌';

  @override
  String get errorExportFailed =>
      'No se pudieron exportar los recuerdos. Por favor, inténtalo de nuevo.';
}
