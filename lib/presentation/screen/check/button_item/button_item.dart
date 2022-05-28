import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';

class ButtonItem extends StatelessWidget {
  final String _text;
  final IconData _icon;
  final Function _onPressed;

  const ButtonItem(this._text, this._icon, this._onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: 150,
        child: TextButton(
            onPressed: () => _onPressed.call(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_icon, color: ColorsRes.green, size: 48.0),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Text(_text, style: _buildTextStyle())
              ],
            )));
  }

  TextStyle _buildTextStyle() {
    return const TextStyle(fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20);
  }
}
