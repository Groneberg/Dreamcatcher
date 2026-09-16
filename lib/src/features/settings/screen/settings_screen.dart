
import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:flutter/material.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final DatabaseService dbService;

  const SettingsScreen({
    super.key,
    required this.dbService,
  });

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
                          onTap: () {
                            // TODO: Show Export Overlay / Modal
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Export options coming soon...')),
                            );
                          },
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
                            // TODO: Show Import Overlay / Modal
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Import options coming soon...')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Hier folgen später weitere Abschnitte (z. B. SECURITY, APPEARANCE, LANGUAGE)
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
  }
}