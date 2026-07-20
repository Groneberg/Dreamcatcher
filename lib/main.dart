import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/data/services/preferences_service.dart';
import 'package:dreamcatcher/src/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'src/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbService = await DatabaseService.init();
  final prefsService = await PreferencesService.init();

  runApp(MyApp(dbService: dbService, prefsService: prefsService));
}

class MyApp extends StatelessWidget {
  final DatabaseService dbService;
  final PreferencesService prefsService;

  const MyApp({super.key, required this.dbService, required this.prefsService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DreamCatcher',
      debugShowCheckedModeBanner: false,


      theme: AppTheme.darkTheme,
      home: HomeScreen(dbService: dbService)
    );
  }
}
