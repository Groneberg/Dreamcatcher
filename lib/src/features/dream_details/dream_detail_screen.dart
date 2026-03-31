import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/dream_button.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
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

  String _formattedDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Dream?>(
      stream: dbService.listenToDreamById(dream.id),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
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
                icon: const Icon(Icons.edit_note, color: AppTheme.burnishedGold, size: 28),
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
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: FrostedGlassBox(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formattedDate(currentDream.date),
                          style: const TextStyle(color: AppTheme.burnishedGold, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentDream.title ?? "Untitled Dream",
                          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        _buildClarityIndicator(currentDream.clarityScore),
                        const Divider(height: 40, color: Colors.white24),
                        Text(
                          currentDream.content,
                          style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.6),
                        ),
                        if (currentDream.tags.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          Wrap(
                            spacing: 8,
                            children: currentDream.tags.map((tag) => Chip(
                              label: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 12)),
                              backgroundColor: AppTheme.lavender.withAlpha(50),
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            )).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildClarityIndicator(int score) {
    return Row(
      children: List.generate(5, (index) => Icon(
        index < score ? Icons.star : Icons.star_border,
        color: AppTheme.burnishedGold,
        size: 20,
      )),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.navyBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("Delete Dream?", style: TextStyle(color: Colors.white)),
        content: const Text("Do you really want this memory to fade away forever?"),
        actions: [
          DreamButton(
            label: "Keep", 
            isPrimary: false, 
            onPressed: () => Navigator.pop(context)
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
            }
          ),
        ],
      ),
    );
  }
}