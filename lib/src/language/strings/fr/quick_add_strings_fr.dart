import '../quick_add_strings.dart';

class QuickAddStringsFr implements QuickAddStrings {
  @override
  String get inputHint => 'Écris-le avant qu’il ne s’évanouisse...';

  @override
  String get emptyDreamError =>
      'Un rêve ne peut pas être vide. Qu’as-tu vu ? 🌌';

  @override
  String get saveError =>
      'La brume est trop épaisse. Impossible de fixer le souvenir. 🌫️';

  @override
  String get buttonAdd => 'À l’attrape-rêves';

  @override
  String get buttonSaving => 'Capture du souvenir...';

  @override
  String get buttonSaved => 'Enregistré en sécurité ! 🌟';

  @override
  String get buttonCancel => 'Annuler';

  @override
  String get snackBarSaved => 'Rêve gardé en sécurité pour plus tard... 🌙';
}
