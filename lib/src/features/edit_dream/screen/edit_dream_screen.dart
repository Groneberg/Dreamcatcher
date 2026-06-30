import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/edit_dream/widgets/dream_form.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EditDreamScreen extends StatelessWidget {
  final DatabaseService dbService;
  final Dream? dreamToEdit;

  const EditDreamScreen({super.key, required this.dbService, this.dreamToEdit});

  Future<void> _handleSave(
    BuildContext context, {
    required String title,
    required String content,
    required DateTime date,
    required int clarity,
    required List<String> tags,
  }) async {
    final dream = Dream(
      id: dreamToEdit?.id ?? 0,
      title: title.isEmpty ? null : title,
      content: content,
      date: date,
      clarityScore: clarity,
      tags: tags,
    );

    await dbService.saveDream(dream);

    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes saved in the ether... 🌙'),
          backgroundColor: AppTheme.navyBlue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = dreamToEdit != null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Dream' : 'New Entry'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: FrostedGlassBox(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: DreamForm(
                  initialDream: dreamToEdit,
                  onSave: (title, content, date, clarity, tags) async {
                    await _handleSave(
                      context,
                      title: title,
                      content: content,
                      date: date,
                      clarity: clarity,
                      tags: tags,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
