import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_app/core/di/injection.dart';
import 'package:awesome_app/core/constant/config_constant.dart';

abstract class Localization {
  static Locale defaultLocale = supportedLocales.first;

  static List<Locale> supportedLocales = [
    const Locale('en'),
    const Locale('id'),
  ];

  static Future<void> saveLanguage(Locale locale) async {
    final sharedPref = await injector.getAsync<SharedPreferences>();

    await sharedPref.setString(ConfigConstant.language, locale.languageCode);
  }

  static Future<Locale> getLanguage() async {
    final sharedPref = await injector.getAsync<SharedPreferences>();
    final languageCode = sharedPref.getString(ConfigConstant.language) ??
        defaultLocale.languageCode;
    final locale = getLocaleFromLanguageCode(languageCode);

    return locale;
  }

  static Locale getLocaleFromLanguageCode(String languageCode) {
    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == languageCode,
      orElse: () => Locale(languageCode),
    );
  }
}
