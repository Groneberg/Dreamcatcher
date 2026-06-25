import 'package:flutter/material.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';

class SearchFilterPanel extends StatelessWidget {
  final DateTimeRange? selectedRange;
  final Function(DateTimeRange?) onRangeSelected;

  const SearchFilterPanel({
    super.key,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  Future<void> _selectCustomRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: selectedRange,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppTheme.deepPurple,
              headerBackgroundColor: AppTheme.navyBlue,
              headerForegroundColor: AppTheme.lavender,
              rangeSelectionBackgroundColor: AppTheme.burnishedGold.withValues(alpha: 0.2),
              rangePickerHeaderBackgroundColor: AppTheme.navyBlue,
              rangePickerHeaderForegroundColor: AppTheme.lavender,
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return AppTheme.navyBlue;
                return AppTheme.lightSterlingSilver;
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return AppTheme.burnishedGold;
                return null;
              }),
            ),
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.burnishedGold,
              onPrimary: AppTheme.navyBlue,
              surface: AppTheme.deepPurple,
              onSurface: AppTheme.lightSterlingSilver,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onRangeSelected(picked);
    }
  }

  /// Calculates a preset range back from the current moment
  void _applyPreset(int days) {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: days));
    onRangeSelected(DateTimeRange(start: start, end: now));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: FrostedGlassBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter by Timeline',
                style: TextStyle(
                  color: AppTheme.lavender,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              // Preset Quick Buttons
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _PresetChip(
                    label: 'Last Night',
                    onPressed: () => _applyPreset(1),
                  ),
                  _PresetChip(
                    label: '7 Days',
                    onPressed: () => _applyPreset(7),
                  ),
                  _PresetChip(
                    label: '30 Days',
                    onPressed: () => _applyPreset(30),
                  ),
                  // Custom Date Range Picker Trigger
                  ActionChip(
                    backgroundColor: AppTheme.deepPurple,
                    avatar: Icon(
                      Icons.calendar_month, 
                      size: 16, 
                      color: selectedRange != null ? AppTheme.burnishedGold : AppTheme.sterlingSilver
                    ),
                    label: Text(
                      selectedRange != null ? 'Custom Active' : 'Select Range...',
                      style: TextStyle(
                        color: selectedRange != null ? AppTheme.burnishedGold : AppTheme.sterlingSilver
                      ),
                    ),
                    onPressed: () => _selectCustomRange(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _PresetChip({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: AppTheme.deepPurple.withValues(alpha: 0.6),
      label: Text(
        label,
        style: const TextStyle(color: AppTheme.lavender, fontSize: 12),
      ),
      onPressed: onPressed,
    );
  }
}
