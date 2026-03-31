import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/edit_dream/widgets/dream_form.dart';
import 'package:flutter/material.dart';


class EditDreamScreen extends StatelessWidget {
  final DatabaseService dbService;
  final Dream? dreamToEdit;

  const EditDreamScreen({
    super.key, 
    required this.dbService, 
    this.dreamToEdit, 
  });

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
            child: FrostedGlassBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: DreamForm(
                  initialDream: dreamToEdit,
                  onSave: (title, content, date, clarity, tags) async {
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