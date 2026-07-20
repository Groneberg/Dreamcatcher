import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/preferences_service.dart';

class AppStateManager extends ChangeNotifier {
  DatabaseService? _dbService;
  PreferencesService? _prefsService;
  bool _isInitialized = false;
  bool _isFirstLaunchAtStart = true;

  bool get isInitialized => _isInitialized;
  DatabaseService get dbService => _dbService!;
  PreferencesService get prefsService => _prefsService!;
  bool get isFirstLaunchAtStart => _isFirstLaunchAtStart;

  Future<void> initializeApp() async {
    if (_isInitialized) return;

    _dbService = await DatabaseService.init();
    _prefsService = await PreferencesService.init();
    _isFirstLaunchAtStart = _prefsService!.isFirstLaunch;
    _isInitialized = true;
    notifyListeners();
  }

  bool get shouldShowQuickAddAsRoot {
    return _isInitialized && !_isFirstLaunchAtStart;
  }
}
