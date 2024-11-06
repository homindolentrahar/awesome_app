import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/core/localization/localization.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(Localization.defaultLocale) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final locale = await Localization.getLanguage();

    emit(locale);
  }

  Future<void> changeLanguage(Locale locale) async {
    await Localization.saveLanguage(locale);

    emit(locale);
  }
}
