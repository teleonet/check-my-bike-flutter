import 'package:flutter/cupertino.dart';

import '../../../resources/colors_res.dart';

class Header extends StatefulWidget {
  final String _text;

  const Header(this._text, {Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
            child: Text(widget._text,
                style:
                    TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 40))));
  }
}
