import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _keyFirstLaunch = 'is_first_launch';
  static const String _keyLanguage = 'selected_language'; // Neu

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  static Future<PreferencesService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService(prefs);
  }

  bool get isFirstLaunch {
    return _prefs.getBool(_keyFirstLaunch) ?? true;
  }

  Future<void> setFirstLaunchCompleted() async {
    await _prefs.setBool(_keyFirstLaunch, false);
  }

  String get languageCode {
    return _prefs.getString(_keyLanguage) ?? 'en';
  }

  Future<void> setLanguageCode(String code) async {
    await _prefs.setString(_keyLanguage, code);
  }
}