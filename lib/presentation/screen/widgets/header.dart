import 'package:flutter/cupertino.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class Header extends StatefulWidget {
  const Header(this._text, {Key? key}) : super(key: key);

  final String _text;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends BaseScreenState<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Center(
            child: Text(widget._text,
                style: TextStyle(fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 40))));
  }
}
