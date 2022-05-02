import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';

class SettingsItem extends StatefulWidget {
  final IconData _icon;
  final String _title;
  final Widget _innerWidget;
  final Function? onPressed;

  const SettingsItem(this._icon, this._title, this._innerWidget, {this.onPressed, Key? key})
      : super(key: key);

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends BaseScreenState<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: _buildContainerDecoration(),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
            style: _buildButtonStyle(),
            onPressed: () => widget.onPressed?.call(),
            child: Row(children: [
              Icon(widget._icon, color: ColorsRes.green, size: 25.0),
              const Spacer(),
              Text(widget._title, style: _buildTextStyle()),
              const Spacer(),
              widget._innerWidget
            ])));
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: ColorsRes.green),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20)));
  }

  TextStyle _buildTextStyle() {
    return TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20);
  }
}
