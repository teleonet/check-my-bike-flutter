// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ua = {
  "checkScreen": {
    "check": "перевірка байку",
    "serial": "серійний номер",
    "manufacturer": "виробник",
    "custom": "свій вибір",
    "location": "локація"
  }
};
static const Map<String,dynamic> pl = {
  "checkScreen": {
    "check": "sprawdź rower",
    "serial": "numer seryjny",
    "manufacturer": "producent",
    "custom": "do wyboru",
    "location": "Lokalizacja"
  }
};
static const Map<String,dynamic> en = {
  "checkScreen": {
    "check": "check",
    "serial": "serial",
    "manufacturer": "manufacturer",
    "custom": "custom",
    "location": "location"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ua": ua, "pl": pl, "en": en};
}
