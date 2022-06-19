class Validator {
  Validator._();

  static bool isMoreOneSymbol(String? text) {
    return isMoreThen(1, text);
  }

  static bool isMoreTwoSymbols(String? text) {
    return isMoreThen(2, text);
  }

  static bool isMoreFourSymbols(String? text) {
    return isMoreThen(4, text);
  }

  static bool isMoreThen(int symbols, String? text) {
    return text != null && text.isNotEmpty && text.length > symbols;
  }

  static bool isOnlyDigitsOrEmpty(String? text) {
    return text != null && (text.isEmpty || double.tryParse(text) != null);
  }
}
