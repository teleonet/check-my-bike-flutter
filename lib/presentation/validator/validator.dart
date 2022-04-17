class Validator {
  Validator._();

  static bool moreThenOneSymbol(String? text) {
    return text != null && text.isNotEmpty && text.length > 1;
  }
}
