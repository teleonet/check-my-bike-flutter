import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class ButtonItem extends StatefulWidget {
  const ButtonItem(this._text, this._icon, this._callback, {Key? key}) : super(key: key);

  final String _text;
  final IconData _icon;
  final Function _callback;

  @override
  _ButtonItemState createState() => _ButtonItemState();
}

class _ButtonItemState extends BaseScreenState<ButtonItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: 150,
        child: TextButton(
            onPressed: () {
              widget._callback;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget._icon, color: ColorRes.green, size: 48.0),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Text(widget._text,
                    style: const TextStyle(
                        fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20))
              ],
            )));
  }
}
