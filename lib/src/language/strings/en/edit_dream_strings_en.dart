import '../edit_dream_strings.dart';

class EditDreamStringsEn implements EditDreamStrings {
  @override
  String get appBarEdit => 'Edit Dream';

  @override
  String get appBarNew => 'New Entry';

  @override
  String get snackBarSaved => 'Changes saved in the ether... 🌙';

  @override
  String get fieldTitleLabel => 'Title (optional)';

  @override
  String get fieldContentLabel => 'What did you experience?';

  @override
  String get fieldContentError => 'Please describe your dream.';

  @override
  String get labelDate => 'Date';

  @override
  String labelClarity(int score) => 'Clarity: $score / 5';

  @override
  String get fieldTagsLabel => 'Tags (separate with commas)';

  @override
  String get buttonSaveNew => 'Save Dream';

  @override
  String get buttonSaveEdit => 'Save Edit';
}
