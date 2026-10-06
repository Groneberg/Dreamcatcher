import '../quick_add_strings.dart';

class QuickAddStringsEs implements QuickAddStrings {
  @override
  String get inputHint => 'Escríbelo antes de que se desvanezca...';

  @override
  String get emptyDreamError => 'Un sueño no puede estar vacío. ¿Qué viste? 🌌';

  @override
  String get saveError =>
      'La niebla es demasiado densa. No se pudo asegurar el recuerdo. 🌫️';

  @override
  String get buttonAdd => 'Al atrapasueños';

  @override
  String get buttonSaving => 'Asegurando el recuerdo...';

  @override
  String get buttonSaved => '¡Guardado con seguridad! 🌟';

  @override
  String get buttonCancel => 'Cancelar';

  @override
  String get snackBarSaved => 'Sueño guardado a salvo para más tarde... 🌙';
}
