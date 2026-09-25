import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/data/services/import/import_service.dart';
import 'package:dreamcatcher/src/features/settings/widgets/export_selection_sheet.dart';
import 'package:dreamcatcher/src/language/language_service.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final DatabaseService dbService;

  const SettingsScreen({
    super.key,
    required this.dbService,
  });

  Future<void> _handleImport(BuildContext context) async {
    final rootContext = context;
    final importService = rootContext.read<ImportService>();
    final strings = rootContext.read<LanguageService>().settingsStrings;

    final dialogResult = await showDialog<String>(
      context: rootContext,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.navyBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppTheme.lavender.withValues(alpha: 0.2),
          ),
        ),
        title: Text(
          strings.restoreDialogTitle,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          strings.restoreDialogContent,
          style: const TextStyle(color: AppTheme.lightSterlingSilver),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, 'cancel'),
            child: Text(
              strings.restoreDialogCancel,
              style: const TextStyle(color: AppTheme.lightSterlingSilver),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, 'export'),
            child: Text(
              strings.restoreDialogExportFirst,
              style: const TextStyle(color: AppTheme.burnishedGold),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, 'overwrite'),
            child: Text(
              strings.restoreDialogOverwrite,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (dialogResult == 'export') {
      if (!rootContext.mounted) return;
      showModalBottomSheet(
        context: rootContext,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (modalContext) => const ExportSelectionSheet(),
      );
      return;
    }

    if (dialogResult != 'overwrite') return;

    final result = await importService.pickAndImportJson();

    if (!rootContext.mounted) return;

    if (result.isSuccess) {
      ScaffoldMessenger.of(rootContext).showSnackBar(
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
          backgroundColor: AppTheme.deepPurple.withValues(alpha: 0.9),
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: AppTheme.burnishedGold),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  strings.importSuccess(result.importedCount),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (result.errorMessage != null) {
      ScaffoldMessenger.of(rootContext).showSnackBar(
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
                  result.errorMessage!,
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
    final languageService = context.watch<LanguageService>();
    final strings = languageService.settingsStrings;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          strings.settingsTitle,
          style: const TextStyle(
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
              _buildSectionHeader(strings.sectionDataManagement),
              const SizedBox(height: 8),
              FrostedGlassBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.upload_file_outlined,
                          label: strings.actionExport,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (modalContext) => const ExportSelectionSheet(),
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
                          label: strings.actionImport,
                          onTap: () => _handleImport(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(strings.sectionLanguage),
              const SizedBox(height: 8),
              FrostedGlassBox(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      _buildLanguageOption(
                        title: 'English',
                        code: 'en',
                        isSelected: languageService.isEnglish,
                        onTap: () => languageService.setLanguage('en'),
                      ),
                      const SizedBox(width: 12),
                      _buildLanguageOption(
                        title: 'Deutsch',
                        code: 'de',
                        isSelected: languageService.isGerman,
                        onTap: () => languageService.setLanguage('de'),
                      ),
                    ],
                  ),
                ),
              ),
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

  Widget _buildLanguageOption({
    required String title,
    required String code,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.deepPurple.withValues(alpha: 0.7)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.burnishedGold : Colors.white12,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? Icons.check : Icons.language_outlined,
                color: isSelected ? AppTheme.burnishedGold : Colors.white54,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppTheme.burnishedGold : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}