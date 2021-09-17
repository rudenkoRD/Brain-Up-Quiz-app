import 'package:flutter/material.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/main.dart';
import 'lang_constants.dart';

class LangHelper {
  Locale currentLocale;

  Future loadCurrentLocale() async {
    currentLocale = await getLocale();
  }

  String getNameOfLangByLocale(context){
    switch(currentLocale.languageCode) {
      case 'ru' : return S.of(context).russian_lang_label;
      case 'en' : return S.of(context).english_lang_label;
      default: throw('locale isn\'t supported');
    }
  }

  changeLanguage(Locale locale, context) async {
    Locale _locale = await setLocale(locale.languageCode);
    MyApp.setLocale(context, _locale);
  }
}