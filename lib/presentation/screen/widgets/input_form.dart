import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../base/base_screen_state.dart';

class InputForm extends StatefulWidget {
  final Function(String) _onSearchPressed;
  final Function(String?) _onValidatorActivated;
  final String _errorValidatorMessage;
  final String _title;

  const InputForm(this._title, this._onSearchPressed, this._onValidatorActivated, this._errorValidatorMessage,
      {Key? key})
      : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends BaseScreenState<InputForm> {
  final _formKey = GlobalKey<FormFieldState<String>>();
  bool _isClearValidation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
        child: TextFormField(
            focusNode: FocusNode(canRequestFocus: false),
            key: _formKey,
            onEditingComplete: () => _pressedSearch(),
            validator: (text) {
              if (_isClearValidation) {
                _isClearValidation = false;
                return null;
              }
              return _isValidInputtedText() ? null : widget._errorValidatorMessage;
            },
            onChanged: (text) {
              _clearValidation();
            },
            maxLines: 1,
            cursorColor: ColorsRes.green,
            autofocus: false,
            style: TextStyle(color: ColorsRes.green, fontFamily: 'Roboto Thin'),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    color: ColorsRes.green,
                    onPressed: () => _pressedSearch()),
                labelStyle: TextStyle(color: ColorsRes.green),
                labelText: widget._title,
                focusedBorder: _buildInputBorder(ColorsRes.green),
                enabledBorder: _buildInputBorder(ColorsRes.darkGreen),
                errorBorder: _buildInputBorder(Colors.red),
                focusedErrorBorder: _buildInputBorder(Colors.red))));
  }

  InputBorder _buildInputBorder(Color color) {
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
      FocusManager.instance.primaryFocus?.unfocus();
      String text = _formKey.currentState!.value!;
      widget._onSearchPressed.call(text);
    }
  }

  bool _isValidInputtedText() {
    return widget._onValidatorActivated.call(_formKey.currentState?.value);
  }
}
