import '../quick_add_strings.dart';

class QuickAddStringsEn implements QuickAddStrings {
  @override
  String get inputHint => 'Write it down before it fades...';

  @override
  String get emptyDreamError => 'A dream cannot be empty. What did you see? 🌌';

  @override
  String get saveError => 'The mist is too thick. Could not secure the memory. 🌫️';

  @override
  String get buttonAdd => 'Add to Dreamcatcher';

  @override
  String get buttonSaving => 'Locking in the memory...';

  @override
  String get buttonSaved => 'Saved securely! 🌟';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get snackBarSaved => 'Dream safely saved for later... 🌙';
}
