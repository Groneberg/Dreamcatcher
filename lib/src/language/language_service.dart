import 'package:flutter/foundation.dart';
import 'package:dreamcatcher/src/data/services/preferences_service.dart';
import 'package:dreamcatcher/src/language/strings/home_strings.dart';
import 'package:dreamcatcher/src/language/strings/quick_add_strings.dart';
import 'package:dreamcatcher/src/language/strings/en/home_strings_en.dart';
import 'package:dreamcatcher/src/language/strings/de/home_strings_de.dart';
import 'package:dreamcatcher/src/language/strings/en/quick_add_strings_en.dart';
import 'package:dreamcatcher/src/language/strings/de/quick_add_strings_de.dart';

class LanguageService extends ChangeNotifier {
  final PreferencesService _prefsService;
  late String _currentLanguageCode;

  LanguageService(this._prefsService) {
    _currentLanguageCode = _prefsService.languageCode;
  }

  String get currentLanguageCode => _currentLanguageCode;
  bool get isGerman => _currentLanguageCode == 'de';
  bool get isEnglish => _currentLanguageCode == 'en';

  HomeStrings get homeStrings {
    switch (_currentLanguageCode) {
      case 'de':
        return HomeStringsDe();
      case 'en':
      default:
        return HomeStringsEn();
    }
  }

  QuickAddStrings get quickAddStrings {
    switch (_currentLanguageCode) {
      case 'de':
        return QuickAddStringsDe();
      case 'en':
      default:
        return QuickAddStringsEn();
    }
  }

  Future<void> setLanguage(String code) async {
    if (_currentLanguageCode == code) return;

    _currentLanguageCode = code;
    await _prefsService.setLanguageCode(code);
    notifyListeners();
  }
}