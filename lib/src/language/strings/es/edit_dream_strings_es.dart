import '../edit_dream_strings.dart';

class EditDreamStringsEs implements EditDreamStrings {
  @override
  String get appBarEdit => 'Editar sueño';

  @override
  String get appBarNew => 'Nueva entrada';

  @override
  String get snackBarSaved => 'Cambios guardados en el éter... 🌙';

  @override
  String get fieldTitleLabel => 'Título (opcional)';

  @override
  String get fieldContentLabel => '¿Qué experimentaste?';

  @override
  String get fieldContentError => 'Por favor, describe tu sueño.';

  @override
  String get labelDate => 'Fecha';

  @override
  String labelClarity(int score) => 'Claridad: $score / 5';

  @override
  String get fieldTagsLabel => 'Etiquetas (separar con comas)';

  @override
  String get buttonSaveNew => 'Guardar sueño';

  @override
  String get buttonSaveEdit => 'Aplicar cambios';
}
