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
}