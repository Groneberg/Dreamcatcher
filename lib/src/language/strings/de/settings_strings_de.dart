import '../settings_strings.dart';

class SettingsStringsDe implements SettingsStrings {
  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get sectionDataManagement => 'DATENVERWALTUNG';

  @override
  String get sectionLanguage => 'SPRACHE';

  @override
  String get actionExport => 'Export';

  @override
  String get actionImport => 'Import';

  @override
  String get restoreDialogTitle => 'Backup wiederherstellen?';

  @override
  String get restoreDialogContent =>
      'Dadurch wird dein aktuelles Journal dauerhaft durch die Backup-Daten ersetzt. Wir empfehlen, den aktuellen Stand vorher zu exportieren.';

  @override
  String get restoreDialogCancel => 'Abbrechen';

  @override
  String get restoreDialogExportFirst => 'Zuerst exportieren';

  @override
  String get restoreDialogOverwrite => 'Überschreiben';

  @override
  String importSuccess(int count) => count == 1
      ? '1 Erinnerung erfolgreich wiederhergestellt! 🌟'
      : '$count Erinnerungen erfolgreich wiederhergestellt! 🌟';
}
