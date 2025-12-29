import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/add_dream/add_dream_screen.dart';
import 'package:flutter/material.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';

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

  void deleteDream(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Dream?'),
        content: const Text(
          'This entry will be permanently deleted. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      await dbService.deleteDream(dream.id);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildClarityStars(int score) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < score ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dream.title ?? 'Onknown Dream'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDreamScreen(
                    dbService: dbService,
                    dreamToEdit: dream,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => deleteDream(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formattedDate(dream.date),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Clarity: ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    _buildClarityStars(dream.clarityScore),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            if (dream.tags.isNotEmpty) ...[
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: dream.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    labelStyle: const TextStyle(fontSize: 12),
                    padding: EdgeInsets.zero,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],

            const Divider(color: Colors.white24),
            const SizedBox(height: 16),

            Text(
              "Dream events",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.grey,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              dream.content,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 16),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
