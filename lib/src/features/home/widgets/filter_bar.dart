import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final bool showTagSuggestions;
  final List<String> allAvailableTags;
  final String searchQuery;
  final List<String> activeTags;
  final DateTimeRange? selectedRange;
  final void Function(String tag) onToggleTag;
  final void Function(DateTimeRange range) onRangeSelected;
  final VoidCallback onClear;
  final void Function(String tag) onRemoveTag;

  const FilterBar({
    Key? key,
    required this.showTagSuggestions,
    required this.allAvailableTags,
    required this.searchQuery,
    required this.activeTags,
    required this.selectedRange,
    required this.onToggleTag,
    required this.onRangeSelected,
    required this.onClear,
    required this.onRemoveTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showTagSuggestions) _buildTagSuggestionsPanel(),
        if (activeTags.isNotEmpty || selectedRange != null)
          _buildActiveFiltersRow(),
      ],
    );
  }

  Widget _buildTagSuggestionsPanel() {
    final filteredTags = allAvailableTags
        .where((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (filteredTags.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: FrostedGlassBox(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Tap to filter by tag:",
                style: TextStyle(
                  color: AppTheme.lightSterlingSilver,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filteredTags.map<Widget>((tag) {
                  final isSelected = activeTags.contains(tag);
                  return GestureDetector(
                    onTap: () => onToggleTag(tag),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.burnishedGold.withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.burnishedGold
                              : AppTheme.lavender.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: isSelected
                              ? AppTheme.burnishedGold
                              : Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFiltersRow() {
    final List<Widget> allChips = [
      ...activeTags.map<Widget>((tag) {
        return Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: InputChip(
            label: Text(
              tag,
              style: const TextStyle(
                color: AppTheme.burnishedGold,
                fontSize: 12,
              ),
            ),
            backgroundColor: AppTheme.burnishedGold.withValues(alpha: 0.1),
            deleteIconColor: AppTheme.burnishedGold,
            onDeleted: () => onRemoveTag(tag),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: AppTheme.burnishedGold, width: 0.5),
          ),
        );
      }),
      if (selectedRange != null)
        Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: InputChip(
            avatar: const Icon(
              Icons.calendar_today,
              size: 12,
              color: AppTheme.burnishedGold,
            ),
            label: Text(
              selectedRange!.start == selectedRange!.end
                  ? '${selectedRange!.start.day}.${selectedRange!.start.month}.${selectedRange!.start.year}'
                  : 'Timeline Filter',
              style: const TextStyle(
                color: AppTheme.burnishedGold,
                fontSize: 12,
              ),
            ),
            backgroundColor: AppTheme.burnishedGold.withValues(alpha: 0.1),
            deleteIconColor: AppTheme.burnishedGold,
            onDeleted: () => onClear(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: AppTheme.burnishedGold, width: 0.5),
          ),
        ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.filter_list,
            color: AppTheme.burnishedGold,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: allChips),
            ),
          ),
          TextButton(
            onPressed: onClear,
            child: const Text(
              "Clear",
              style: TextStyle(color: AppTheme.lavender, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
