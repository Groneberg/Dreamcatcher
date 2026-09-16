import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/data/services/export/export_service.dart';
import 'package:dreamcatcher/src/data/services/export/formatters/json_dream_exporter.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final DatabaseService dbService;

  const SettingsScreen({
    super.key,
    required this.dbService,
  });

  Future<void> _handleExport(BuildContext context) async {
    final exportService = context.read<ExportService>();

    // Position des Buttons für das iPadOS-Popover ermitteln
    final renderBox = context.findRenderObject() as RenderBox?;
    final origin = renderBox != null
        ? renderBox.localToGlobal(Offset.zero) & renderBox.size
        : null;

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
          content: Text(message),
          backgroundColor: AppTheme.navyBlue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.lavender,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            children: [
              _buildSectionHeader('DATA MANAGEMENT'),
              const SizedBox(height: 8),
              FrostedGlassBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.upload_file_outlined,
                          label: 'Export',
                          onTap: () => _handleExport(context),
                        ),
                      ),
                      Container(
                        height: 36,
                        width: 1,
                        color: Colors.white12,
                        margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      ),
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.download_for_offline_outlined,
                          label: 'Import',
                          onTap: () {
                            // Bleibt vorbereitet für Phase 4 (Import-Picker)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Import options coming soon...'),
                                backgroundColor: AppTheme.navyBlue,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.lightSterlingSilver,
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Builder(
      builder: (tileContext) {
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppTheme.deepPurple.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(icon, color: AppTheme.burnishedGold, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}