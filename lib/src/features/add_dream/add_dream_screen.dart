import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/add_dream/widgets/dream_form.dart';
import 'package:flutter/material.dart';



class AddDreamScreen extends StatelessWidget {
  final DatabaseService dbService;

  const AddDreamScreen({super.key, required this.dbService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neuer Traum'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DreamForm(
            onSave: (title, content, date, clarity, tags) async {
              
              final newDream = Dream(
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