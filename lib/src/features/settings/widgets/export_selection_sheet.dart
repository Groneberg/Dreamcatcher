import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dreamcatcher/src/data/services/export/export_service.dart';
import 'package:dreamcatcher/src/data/services/export/formatters/json_dream_exporter.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';

class ExportSelectionSheet extends StatelessWidget {
  const ExportSelectionSheet({super.key});

  Future<void> _runExport(BuildContext context) async {
    final exportService = context.read<ExportService>();

    final renderBox = context.findRenderObject() as RenderBox?;
    final origin = renderBox != null
        ? renderBox.localToGlobal(Offset.zero) & renderBox.size
        : null;

    Navigator.of(context).pop();

    try {
      await exportService.exportDreams(
        exporter: JsonDreamExporter(),
        sharePositionOrigin: origin,
      );
    } catch (e) {
      if (!context.mounted) return;

      final message = e.toString().contains('No dreams')
          ? 'No memories to export yet. 🌌'
          : 'Could not export memories. Please try again.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: AppTheme.lavender.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          elevation: 4,
          backgroundColor: const Color(0xFF3B1E2B),
          content: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white70),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.navyBlue.withValues(alpha: 0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: AppTheme.lavender.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppTheme.lavender.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 12.0),
              child: Text(
                'CHOOSE EXPORT FORMAT',
                style: TextStyle(
                  color: AppTheme.lightSterlingSilver,
                  fontSize: 12,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildOptionTile(
              icon: Icons.data_object,
              title: 'JSON Backup',
              description: 'Full uncompressed archive for restoration',
              onTap: () => _runExport(context),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.deepPurple.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.deepPurple.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.burnishedGold, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      color: AppTheme.lightSterlingSilver,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white30,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}