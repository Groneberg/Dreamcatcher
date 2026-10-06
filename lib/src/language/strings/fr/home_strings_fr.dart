import '../home_strings.dart';

class HomeStringsFr implements HomeStrings {
  @override
  String get greetingMorning => 'Bonjour. As-tu bien dormi ?';

  @override
  String get greetingAfternoon => 'Bon retour.';

  @override
  String get greetingNight => 'La nuit est tombée. As-tu rêvé ?';

  @override
  String get searchHintText => 'Cherche dans ton subconscient...';

  @override
  String get searchTagsHintText => 'Rechercher des tags (ex. Lucide, Vol)...';

  @override
  String get errorLoadingMemories => 'Erreur lors du chargement des souvenirs.';

  @override
  String get noFilteredMemories =>
      'Aucun souvenir ne correspond à tes filtres actifs. 🌫️';

  @override
  String get emptyStateTitle => 'La nuit laisse son empreinte.';

  @override
  String get emptyStateSubtitle => 'Ici, chaque rêve trouve un refuge sûr.';

  @override
  String get unknownDreamTitle => 'Rêve inconnu';

  @override
  String get tagFilterHint => 'Touche pour filtrer par tag :';

  @override
  String get timelineFilterChip => 'Filtre temporel actif';

  @override
  String get clearFilters => 'Réinitialiser';

  @override
  String get timelineFilterTitle => 'Filtrer par période';

  @override
  String get presetLastNight => 'Cette nuit';

  @override
  String get presetSevenDays => '7 jours';

  @override
  String get presetThirtyDays => '30 jours';

  @override
  String get customRangeActive => 'Période active';

  @override
  String get selectRange => 'Sélectionner une période...';
}
