import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/language/language_service.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamDetailContent extends StatelessWidget {
  final Dream dream;

  const DreamDetailContent({super.key, required this.dream});

  String _formattedDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
  }

  Widget _buildClarityIndicator(int score) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < score ? Icons.star : Icons.star_border,
          color: AppTheme.burnishedGold,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.watch<LanguageService>().dreamDetailStrings;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: FrostedGlassBox(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formattedDate(dream.date),
                style: const TextStyle(
                  color: AppTheme.burnishedGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dream.title ?? strings.untitledDreamTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildClarityIndicator(dream.clarityScore),
              const Divider(height: 40, color: Colors.white24),
              Text(
                dream.content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.6,
                ),
              ),
              if (dream.tags.isNotEmpty) ...[
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  children: dream.tags
                      .map(
                        (tag) => Chip(
                          label: Text(
                            tag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: AppTheme.lavender.withAlpha(50),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
