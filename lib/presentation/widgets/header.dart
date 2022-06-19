import 'package:flutter/cupertino.dart';

import '../../../resources/colors_res.dart';

class Header extends StatelessWidget {
  final String _text;

  const Header(this._text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(child: Text(_text, style: _buildTextStyle())));
  }

  TextStyle _buildTextStyle() {
    return TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 40);
  }
}
