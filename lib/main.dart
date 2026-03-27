import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/add_dream/add_dream_screen.dart';
import 'package:dreamcatcher/src/features/add_dream/widgets/dream_form.dart';
import 'package:dreamcatcher/src/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'src/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbService = await DatabaseService.init();

  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatelessWidget {
  final DatabaseService dbService;

  const MyApp({super.key, required this.dbService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DreamCatcher',
      debugShowCheckedModeBanner: false,


      theme: AppTheme.darkTheme,
      home: HomeScreen(dbService: dbService)
      // AddDreamScreen(dbService: dbService)
    );
  }
}
