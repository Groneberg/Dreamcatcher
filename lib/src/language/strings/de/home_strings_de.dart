import '../home_strings.dart';

class HomeStringsDe implements HomeStrings {
  @override
  String get greetingMorning => 'Guten Morgen. Gut geschlafen?';

  @override
  String get greetingAfternoon => 'Willkommen zurück.';

  @override
  String get greetingNight => 'Die Nacht ist da. Träume gehabt?';

  @override
  String get searchHintText => 'Durchsuche dein Unterbewusstsein...';

  @override
  String get searchTagsHintText => 'Tags suchen (z. B. Luzid, Fliegen)...';

  @override
  String get errorLoadingMemories => 'Fehler beim Laden der Erinnerungen.';

  @override
  String get noFilteredMemories => 'Keine Erinnerungen passen zu deinen aktiven Filtern. 🌫️';

  @override
  String get emptyStateTitle => 'Die Nacht hinterlässt ihre Spuren.';

  @override
  String get emptyStateSubtitle => 'Hier findet jeder Traum einen sicheren Ort.';
}