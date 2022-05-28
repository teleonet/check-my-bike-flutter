import 'package:flutter/services.dart';

class ScreenUtils {
  ScreenUtils._();

  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
