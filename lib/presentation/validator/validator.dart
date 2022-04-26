class Validator {
  Validator._();

  static bool moreThenOneSymbol(String? text) {
    return text != null && text.isNotEmpty && text.length > 1;
  }

  static bool moreThenFourSymbols(String? text) {
    return text != null && text.isNotEmpty && text.length > 4;
  }
}
