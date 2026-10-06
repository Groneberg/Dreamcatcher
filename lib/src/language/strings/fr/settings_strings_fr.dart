import '../settings_strings.dart';

class SettingsStringsFr implements SettingsStrings {
  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get sectionDataManagement => 'GESTION DES DONNÉES';

  @override
  String get sectionLanguage => 'LANGUE';

  @override
  String get actionExport => 'Exporter';

  @override
  String get actionImport => 'Importer';

  @override
  String get restoreDialogTitle => 'Restaurer la sauvegarde ?';

  @override
  String get restoreDialogContent =>
      'Cela remplacera définitivement ton journal actuel par les données de sauvegarde. Nous te conseillons d’exporter ton état actuel au préalable.';

  @override
  String get restoreDialogCancel => 'Annuler';

  @override
  String get restoreDialogExportFirst => 'Exporter d’abord';

  @override
  String get restoreDialogOverwrite => 'Écraser';

  @override
  String importSuccess(int count) => count == 1
      ? '1 souvenir restauré avec succès ! 🌟'
      : '$count souvenirs restaurés avec succès ! 🌟';
}
