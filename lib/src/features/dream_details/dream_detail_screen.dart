import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/dream_button.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/features/dream_details/widgets/dream_detail_content.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/edit_dream/screen/edit_dream_screen.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DreamDetailScreen extends StatelessWidget {
  final Dream dream;
  final DatabaseService dbService;

  const DreamDetailScreen({
    super.key,
    required this.dream,
    required this.dbService,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Dream?>(
      stream: dbService.listenToDreamById(dream.id),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pop(context),
          );
          return const SizedBox.shrink();
        }

        final currentDream = snapshot.data ?? dream;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.edit_note,
                  color: AppTheme.burnishedGold,
                  size: 28,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDreamScreen(
                      dbService: dbService,
                      dreamToEdit: currentDream,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => _confirmDelete(context),
              ),
            ],
          ),
          body: BackgroundContainer(
            child: SafeArea(child: DreamDetailContent(dream: currentDream)),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.navyBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "Delete Dream?",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Do you really want this memory to fade away forever?",
        ),
        actions: [
          DreamButton(
            label: "Keep",
            isPrimary: false,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 8),
          DreamButton(
            label: "Delete",
            onPressed: () async {
              await dbService.deleteDream(dream.id);
              if (context.mounted) {
                Navigator.of(context).pop(); // Dialog schließen
                Navigator.of(context).pop(); // Zurück zum HomeScreen
              }
            },
          ),
        ],
      ),
    );
  }
}
