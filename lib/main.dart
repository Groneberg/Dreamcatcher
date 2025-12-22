import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  // 1. Flutter Bindings initialisieren
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Speicherort für die Datenbank finden
  final dir = await getApplicationDocumentsDirectory();

  // 3. Isar Instanz öffnen
  // Wir speichern die Instanz hier einfachheitshalber global oder übergeben sie später
  final isar = await Isar.open(
    [DreamSchema], // Das Schema wurde vom Generator erstellt
    directory: dir.path,
  );

  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traumtagebuch',
      debugShowCheckedModeBanner: false,
      // Unser besprochenes Theme-Konzept
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF0A0E21), // Sehr dunkles Blau
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Willkommen im Traumtagebuch'),
        ),
      ),
    );
  }
}