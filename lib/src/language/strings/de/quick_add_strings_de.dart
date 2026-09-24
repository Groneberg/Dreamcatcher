import '../quick_add_strings.dart';

class QuickAddStringsDe implements QuickAddStrings {
  @override
  String get inputHint => 'Schreib es auf, bevor es verblasst...';

  @override
  String get emptyDreamError => 'Ein Traum kann nicht leer sein. Was hast du gesehen? 🌌';

  @override
  String get saveError => 'Der Nebel ist zu dicht. Die Erinnerung konnte nicht gesichert werden. 🌫️';

  @override
  String get buttonAdd => 'In den Traumfänger';

  @override
  String get buttonSaving => 'Erinnerung wird gesichert...';

  @override
  String get buttonSaved => 'Sicher aufbewahrt! 🌟';

  @override
  String get buttonCancel => 'Abbrechen';

  @override
  String get snackBarSaved => 'Traum sicher für später gespeichert... 🌙';
}
