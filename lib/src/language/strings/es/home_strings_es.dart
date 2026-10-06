import '../home_strings.dart';

class HomeStringsEs implements HomeStrings {
  @override
  String get greetingMorning => 'Buenos días. ¿Dormiste bien?';

  @override
  String get greetingAfternoon => 'Bienvenido de nuevo.';

  @override
  String get greetingNight => 'Llegó la noche. ¿Tuviste algún sueño?';

  @override
  String get searchHintText => 'Busca en tu subconsciente...';

  @override
  String get searchTagsHintText =>
      'Buscar etiquetas (p. ej., Lúcido, Volar)...';

  @override
  String get errorLoadingMemories => 'Error al cargar los recuerdos.';

  @override
  String get noFilteredMemories =>
      'Ningún recuerdo coincide con tus filtros activos. 🌫️';

  @override
  String get emptyStateTitle => 'La noche deja su huella.';

  @override
  String get emptyStateSubtitle => 'Aquí cada sueño encuentra un lugar seguro.';

  @override
  String get unknownDreamTitle => 'Sueño desconocido';

  @override
  String get tagFilterHint => 'Toca para filtrar por etiqueta:';

  @override
  String get timelineFilterChip => 'Filtro temporal activo';

  @override
  String get clearFilters => 'Restablecer';

  @override
  String get timelineFilterTitle => 'Filtrar por tiempo';

  @override
  String get presetLastNight => 'Anoche';

  @override
  String get presetSevenDays => '7 días';

  @override
  String get presetThirtyDays => '30 días';

  @override
  String get customRangeActive => 'Rango activo';

  @override
  String get selectRange => 'Seleccionar rango...';
}
