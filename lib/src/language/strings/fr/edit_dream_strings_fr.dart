import '../edit_dream_strings.dart';

class EditDreamStringsFr implements EditDreamStrings {
  @override
  String get appBarEdit => 'Modifier le rêve';

  @override
  String get appBarNew => 'Nouvelle entrée';

  @override
  String get snackBarSaved => 'Changements enregistrés dans l’éther... 🌙';

  @override
  String get fieldTitleLabel => 'Titre (optionnel)';

  @override
  String get fieldContentLabel => 'Qu’as-tu vécu ?';

  @override
  String get fieldContentError => 'Merci de décrire ton rêve.';

  @override
  String get labelDate => 'Date';

  @override
  String labelClarity(int score) => 'Clarté : $score / 5';

  @override
  String get fieldTagsLabel => 'Tags (séparer par des virgules)';

  @override
  String get buttonSaveNew => 'Enregistrer le rêve';

  @override
  String get buttonSaveEdit => 'Appliquer les modifications';
}
