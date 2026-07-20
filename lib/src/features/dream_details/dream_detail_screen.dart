import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/dream_button.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/dream_details/widgets/dream_detail_content.dart';
import 'package:dreamcatcher/src/features/edit_dream/screen/edit_dream_screen.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamDetailScreen extends StatelessWidget {
  final Dream dream;

  const DreamDetailScreen({
    super.key,
    required this.dream,
  });

  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<DatabaseService>(context, listen: false);

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (modalContext) => Provider.value(
                        value: dbService,
                        child: EditDreamScreen(
                          dreamToEdit: currentDream,
                        ),
                      ),
                    ),
                  );
                },
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
    final dbService = Provider.of<DatabaseService>(context, listen: false);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
            onPressed: () => Navigator.pop(dialogContext),
          ),
          const SizedBox(height: 8),
          DreamButton(
            label: "Delete",
            onPressed: () async {
              await dbService.deleteDream(dream.id);
              if (context.mounted) {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
