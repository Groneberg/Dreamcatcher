import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/add_dream/widgets/dream_form.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';



class AddDreamScreen extends StatelessWidget {
  final DatabaseService dbService;
  final Dream? dreamToEdit;

const AddDreamScreen({
    super.key, 
    required this.dbService, 
    this.dreamToEdit, 
  });

  @override
  Widget build(BuildContext context) {
    final isEditing = dreamToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Dream' : 'Add Dream'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DreamForm(
            initialDream: dreamToEdit,
            onSave: (title, content, date, clarity, tags) async {

              final id = dreamToEdit?.id ?? Isar.autoIncrement;
              
              final newDream = Dream(
                id: id,
                title: title.isEmpty ? null : title,
                content: content,
                date: date,
                clarityScore: clarity,
                tags: tags,
              );

              await dbService.saveDream(newDream);

              if (context.mounted) {
                Navigator.of(context).pop();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Drem saved! 🌙')),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}