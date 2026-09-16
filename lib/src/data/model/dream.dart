import 'package:objectbox/objectbox.dart';

@Entity()
class Dream {
  @Id()
  int id;

  @Index()
  String? title;

  @Index(type: IndexType.value)
  String content;

  @Property(type: PropertyType.date)
  DateTime date;

  int clarityScore;
  List<String> tags;

  Dream({
    this.id = 0,
    this.title,
    required this.content,
    required this.date,
    required this.clarityScore,
    this.tags = const [],
  });

  Dream copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? date,
    int? clarityScore,
    List<String>? tags,
  }) {
    return Dream(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      clarityScore: clarityScore ?? this.clarityScore,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'clarityScore': clarityScore,
      'tags': tags,
    };
  }

  factory Dream.fromJson(Map<String, dynamic> json, {bool preserveId = false}) {
    final rawDate = json['date'];
    DateTime parsedDate;
    if (rawDate is String) {
      parsedDate = DateTime.tryParse(rawDate) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    final rawTags = json['tags'];
    List<String> parsedTags = [];
    if (rawTags is List) {
      parsedTags = rawTags.map((e) => e.toString()).toList();
    }

    return Dream(
      id: preserveId ? (json['id'] as int? ?? 0) : 0,
      title: json['title'] as String?,
      content: json['content'] as String? ?? '',
      date: parsedDate,
      clarityScore: json['clarityScore'] as int? ?? 0,
      tags: parsedTags,
    );
  }
}
