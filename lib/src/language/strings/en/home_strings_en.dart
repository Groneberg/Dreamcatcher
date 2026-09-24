import '../home_strings.dart';

class HomeStringsEn implements HomeStrings {
  @override
  String get greetingMorning => 'Good morning. Sleep well?';

  @override
  String get greetingAfternoon => 'Welcome back.';

  @override
  String get greetingNight => 'The night is here. Any dreams?';

  @override
  String get searchHintText => 'Search your subconscious...';

  @override
  String get searchTagsHintText => 'Search tags (e.g., Lucid, Flight)...';

  @override
  String get errorLoadingMemories => 'Error loading memories.';

  @override
  String get noFilteredMemories => 'No memories match your active filters. 🌫️';

  @override
  String get emptyStateTitle => 'The night leaves its mark.';

  @override
  String get emptyStateSubtitle => 'Every dream finds a safe place here.';

  @override
  String get unknownDreamTitle => 'Unknown Dream';

  @override
  String get tagFilterHint => 'Tap to filter by tag:';

  @override
  String get timelineFilterChip => 'Timeline Filter';

  @override
  String get clearFilters => 'Clear';

  @override
  String get timelineFilterTitle => 'Filter by Timeline';

  @override
  String get presetLastNight => 'Last Night';

  @override
  String get presetSevenDays => '7 Days';

  @override
  String get presetThirtyDays => '30 Days';

  @override
  String get customRangeActive => 'Custom Active';

  @override
  String get selectRange => 'Select Range...';
}