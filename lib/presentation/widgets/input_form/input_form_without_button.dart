import 'package:check_my_bike_flutter/presentation/widgets/input_form/input_form.dart';
import 'package:flutter/material.dart';

class InputFormWithoutButton extends InputForm {
  const InputFormWithoutButton(
      String _title, _onSearchPressed, _onValidatorActivated, _errorValidatorMessage,
      {Key? key})
      : super(_title, _onSearchPressed, _onValidatorActivated, _errorValidatorMessage, key: key);

  @override
  _InputFormWithoutButtonState createState() => _InputFormWithoutButtonState();
}

class _InputFormWithoutButtonState extends InputFormState {
  @override
  IconButton? getIconButton() {
    return null;
  }
}
