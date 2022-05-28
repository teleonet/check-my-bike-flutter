import 'package:check_my_bike_flutter/presentation/base/base_screen_state.dart';
import 'package:check_my_bike_flutter/presentation/utils/screen_utils.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';

class InputForm extends StatefulWidget {
  final Function(String?) _onPressedSearch;
  final Function(String?) _onActivatedValidator;
  final String _errorValidatorMessage;
  final String _title;

  const InputForm(
      this._title, this._onPressedSearch, this._onActivatedValidator, this._errorValidatorMessage,
      {Key? key})
      : super(key: key);

  @override
  InputFormState createState() => InputFormState();
}

class InputFormState extends BaseScreenState<InputForm> {
  final GlobalKey<FormFieldState<String>> _formKey = GlobalKey<FormFieldState<String>>();
  bool _isClearValidation = false;

  @protected
  IconButton? getIconButton() {
    return IconButton(
        icon: const Icon(Icons.search), color: ColorsRes.green, onPressed: () => _pressedSearch());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
            child: TextFormField(
                focusNode: FocusNode(canRequestFocus: false),
                key: _formKey,
                maxLines: 1,
                cursorColor: ColorsRes.green,
                autofocus: false,
                style: _buildTextStyle(),
                decoration: _buildInputDecoration(),
                onEditingComplete: () => _pressedSearch(),
                onChanged: (text) => _clearValidation(),
                validator: (text) {
                  if (_isClearValidation) {
                    _isClearValidation = false;
                    return null;
                  }
                  return _isValidInputtedText() ? null : widget._errorValidatorMessage;
                })));
  }

  TextStyle _buildTextStyle() {
    return TextStyle(color: ColorsRes.green, fontFamily: 'Roboto Thin');
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
        suffixIcon: getIconButton(),
        labelStyle: _buildTextStyle(),
        labelText: widget._title,
        focusedBorder: _buildBorder(color: ColorsRes.green),
        enabledBorder: _buildBorder(color: ColorsRes.darkGreen),
        errorBorder: _buildBorder(),
        focusedErrorBorder: _buildBorder());
  }

  InputBorder _buildBorder({Color color = Colors.red}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: color, width: 0.5),
    );
  }

  void _clearValidation() {
    _isClearValidation = true;
    _formKey.currentState?.validate();
  }

  void _pressedSearch() {
    _formKey.currentState?.validate();

    if (_isValidInputtedText()) {
      ScreenUtils.hideKeyboard();
      String? text = _formKey.currentState?.value;
      _formKey.currentState?.save();
      widget._onPressedSearch.call(text);
    }
  }

  bool _isValidInputtedText() {
    return widget._onActivatedValidator.call(_formKey.currentState?.value);
  }
}
