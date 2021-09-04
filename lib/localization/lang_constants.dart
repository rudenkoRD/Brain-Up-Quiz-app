import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LANGUAGE_CODE = 'languageCode';

const String ENGLISH = 'en';
const String RUSSIAN = 'ru';

Locale _locale(String langCode) {
  switch(langCode){
    case ENGLISH: return Locale(ENGLISH, 'US');
    case RUSSIAN: return Locale(RUSSIAN, 'RU');
    default: throw('this lang code: $langCode isn\'t supported');
  }
}

Future<Locale> setLocale(String langCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, langCode);
  return _locale(langCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String langCode = _prefs.getString(LANGUAGE_CODE) ?? 'en';
  return _locale(langCode);
}