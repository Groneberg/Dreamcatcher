import '../settings_strings.dart';

class SettingsStringsEs implements SettingsStrings {
  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get sectionDataManagement => 'GESTIÓN DE DATOS';

  @override
  String get sectionLanguage => 'IDIOMA';

  @override
  String get actionExport => 'Exportar';

  @override
  String get actionImport => 'Importar';

  @override
  String get restoreDialogTitle => '¿Restaurar copia de seguridad?';

  @override
  String get restoreDialogContent =>
      'Esto reemplazará permanentemente tu diario actual con los datos de la copia de seguridad. Recomendamos exportar tu estado actual primero.';

  @override
  String get restoreDialogCancel => 'Cancelar';

  @override
  String get restoreDialogExportFirst => 'Exportar primero';

  @override
  String get restoreDialogOverwrite => 'Sobrescribir';

  @override
  String importSuccess(int count) => count == 1
      ? '¡1 recuerdo restaurado con éxito! 🌟'
      : '¡$count recuerdos restaurados con éxito! 🌟';
}
