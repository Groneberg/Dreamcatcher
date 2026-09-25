import '../edit_dream_strings.dart';

class EditDreamStringsDe implements EditDreamStrings {
  @override
  String get appBarEdit => 'Traum bearbeiten';

  @override
  String get appBarNew => 'Neuer Eintrag';

  @override
  String get snackBarSaved => 'Änderungen im Äther gespeichert... 🌙';

  @override
  String get fieldTitleLabel => 'Titel (optional)';

  @override
  String get fieldContentLabel => 'Was hast du erlebt?';

  @override
  String get fieldContentError => 'Bitte beschreibe deinen Traum.';

  @override
  String get labelDate => 'Datum';

  @override
  String labelClarity(int score) => 'Klarheit: $score / 5';

  @override
  String get fieldTagsLabel => 'Tags (mit Kommas trennen)';

  @override
  String get buttonSaveNew => 'Traum speichern';

  @override
  String get buttonSaveEdit => 'Änderungen übernehmen';
}
