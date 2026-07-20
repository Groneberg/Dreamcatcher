import 'package:dreamcatcher/src/data/manager/app_state_manager.dart';
import 'package:dreamcatcher/src/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'DreamCatcher',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Consumer<AppStateManager>(
        builder: (context, stateManager, child) {
          if (!stateManager.isInitialized) {
            return const Scaffold(
              backgroundColor: Color(0xff0A1128),
              body: Center(
                child: CircularProgressIndicator(color: AppTheme.lavender),
              ),
            );
          }

          print("DEBUG: isFirstLaunchAtStart = ${stateManager.isFirstLaunchAtStart}");
          print("DEBUG: shouldShowQuickAddAsRoot = ${stateManager.shouldShowQuickAddAsRoot}");

          return MultiProvider(
            providers: [
              Provider.value(value: stateManager.dbService),
              Provider.value(value: stateManager.prefsService),
            ],
            child: HomeScreen(
              isFirstLaunch: stateManager.isFirstLaunchAtStart,
              showQuickAddOnStart: stateManager.shouldShowQuickAddAsRoot,
            ),
          );
        },
      ),
    );
  }
}
