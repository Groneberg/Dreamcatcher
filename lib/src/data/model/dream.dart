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
}