import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../base/base_screen_state.dart';

class CheckButtonItem extends StatefulWidget {
  final String _text;
  final IconData _icon;
  final Function _onPressed;

  const CheckButtonItem(this._text, this._icon, this._onPressed, {Key? key}) : super(key: key);

  @override
  _CheckButtonItemState createState() => _CheckButtonItemState();
}

class _CheckButtonItemState extends BaseScreenState<CheckButtonItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: 150,
        child: TextButton(
            onPressed: () => widget._onPressed.call(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget._icon, color: ColorsRes.green, size: 48.0),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Text(widget._text, style: _buildTextStyle())
              ],
            )));
  }

  TextStyle _buildTextStyle() {
    return const TextStyle(fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20);
  }
}
