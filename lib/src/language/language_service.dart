import 'package:flutter/foundation.dart';
import 'package:dreamcatcher/src/data/services/preferences_service.dart';
import 'package:dreamcatcher/src/language/strings/home_strings.dart';
import 'package:dreamcatcher/src/language/strings/quick_add_strings.dart';
import 'package:dreamcatcher/src/language/strings/settings_strings.dart';
import 'package:dreamcatcher/src/language/strings/export_selection_strings.dart';
import 'package:dreamcatcher/src/language/strings/edit_dream_strings.dart';
import 'package:dreamcatcher/src/language/strings/dream_detail_strings.dart';
import 'package:dreamcatcher/src/language/strings/en/home_strings_en.dart';
import 'package:dreamcatcher/src/language/strings/de/home_strings_de.dart';
import 'package:dreamcatcher/src/language/strings/en/quick_add_strings_en.dart';
import 'package:dreamcatcher/src/language/strings/de/quick_add_strings_de.dart';
import 'package:dreamcatcher/src/language/strings/en/settings_strings_en.dart';
import 'package:dreamcatcher/src/language/strings/de/settings_strings_de.dart';
import 'package:dreamcatcher/src/language/strings/en/export_selection_strings_en.dart';
import 'package:dreamcatcher/src/language/strings/de/export_selection_strings_de.dart';
import 'package:dreamcatcher/src/language/strings/en/edit_dream_strings_en.dart';
import 'package:dreamcatcher/src/language/strings/de/edit_dream_strings_de.dart';
import 'package:dreamcatcher/src/language/strings/en/dream_detail_strings_en.dart';
import 'package:dreamcatcher/src/language/strings/de/dream_detail_strings_de.dart';

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

  SettingsStrings get settingsStrings {
    switch (_currentLanguageCode) {
      case 'de':
        return SettingsStringsDe();
      case 'en':
      default:
        return SettingsStringsEn();
    }
  }

  ExportSelectionStrings get exportSelectionStrings {
    switch (_currentLanguageCode) {
      case 'de':
        return ExportSelectionStringsDe();
      case 'en':
      default:
        return ExportSelectionStringsEn();
    }
  }

  EditDreamStrings get editDreamStrings {
    switch (_currentLanguageCode) {
      case 'de':
        return EditDreamStringsDe();
      case 'en':
      default:
        return EditDreamStringsEn();
    }
  }

  DreamDetailStrings get dreamDetailStrings {
    switch (_currentLanguageCode) {
      case 'de':
        return DreamDetailStringsDe();
      case 'en':
      default:
        return DreamDetailStringsEn();
    }
  }

  Future<void> setLanguage(String code) async {
    if (_currentLanguageCode == code) return;

    _currentLanguageCode = code;
    await _prefsService.setLanguageCode(code);
    notifyListeners();
  }
}