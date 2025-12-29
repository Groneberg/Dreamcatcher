import 'package:flutter/material.dart';
import '../../data/model/dream.dart';

class DreamDetailScreen extends StatelessWidget {
  final Dream dream;

  const DreamDetailScreen({super.key, required this.dream});

  String _formattedDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
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
        title: Text(dream.title ?? 'Unkown Dream'),
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
                    const Icon(Icons.calendar_month, size: 18, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      _formattedDate(dream.date),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Klarheit: ", style: TextStyle(color: Colors.grey)),
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
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
              "Traumgeschehen",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.grey, 
                letterSpacing: 1.2
              ),
            ),
            const SizedBox(height: 12),
            
            Text(
              dream.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                fontSize: 16,
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}