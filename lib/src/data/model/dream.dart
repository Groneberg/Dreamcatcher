import 'package:isar/isar.dart';

part 'dream.g.dart'; 

@collection
class Dream {
  Id id; 

  String? title;
  
  @Index(type: IndexType.value)
  String content;

  @Index()
  DateTime date;
  
  int clarityScore; 
  
  @Index(type: IndexType.value)
  List<String> tags; 
  
  Dream({
    this.id = Isar.autoIncrement, 
    this.title,
    required this.content,
    required this.date,
    required this.clarityScore,
    this.tags = const [],
  });

  Dream copyWith({
    Id? id,
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