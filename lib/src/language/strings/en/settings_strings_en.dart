import '../settings_strings.dart';

class SettingsStringsEn implements SettingsStrings {
  @override
  String get settingsTitle => 'Settings';

  @override
  String get sectionDataManagement => 'DATA MANAGEMENT';

  @override
  String get sectionLanguage => 'LANGUAGE';

  @override
  String get actionExport => 'Export';

  @override
  String get actionImport => 'Import';

  @override
  String get restoreDialogTitle => 'Restore Backup?';

  @override
  String get restoreDialogContent =>
      'This will permanently replace your current journal with the backup data. We recommend exporting your current state first.';

  @override
  String get restoreDialogCancel => 'Cancel';

  @override
  String get restoreDialogExportFirst => 'Export First';

  @override
  String get restoreDialogOverwrite => 'Overwrite';

  @override
  String importSuccess(int count) => count == 1
      ? 'Restored 1 memory successfully! 🌟'
      : 'Restored $count memories successfully! 🌟';
}
