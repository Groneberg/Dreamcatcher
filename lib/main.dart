import 'package:dreamcatcher/src/data/manager/app_state_manager.dart';
import 'package:dreamcatcher/src/data/services/export/export_service.dart';
import 'package:dreamcatcher/src/data/services/import/import_service.dart';
import 'package:dreamcatcher/src/features/home/screen/home_screen.dart';
import 'package:dreamcatcher/src/language/language_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'src/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppStateManager()..initializeApp(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, stateManager, child) {
        if (!stateManager.isInitialized) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Color(0xff0A1128),
              body: Center(
                child: CircularProgressIndicator(color: AppTheme.lavender),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            Provider.value(value: stateManager.dbService),
            Provider.value(value: stateManager.prefsService),
            ChangeNotifierProvider<LanguageService>(
              create: (_) => LanguageService(stateManager.prefsService),
            ),
            Provider<ExportService>(
              create: (_) => ExportService(stateManager.dbService),
            ),
            Provider<ImportService>(
              create: (_) => ImportService(stateManager.dbService),
            ),
          ],
          child: Builder(
            builder: (context) {
              final currentLanguageCode = context.watch<LanguageService>().currentLanguageCode;

              return MaterialApp(
                title: 'DreamCatcher',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.darkTheme,
                locale: Locale(currentLanguageCode),
                supportedLocales: const [
                  Locale('en'),
                  Locale('de'),
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: HomeScreen(
                  isFirstLaunch: stateManager.isFirstLaunchAtStart,
                  showQuickAddOnStart: stateManager.shouldShowQuickAddAsRoot,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
