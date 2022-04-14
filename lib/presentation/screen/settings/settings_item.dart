import 'package:flutter/material.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem(this._icon, this._title, this._innerWidget, this._callback, {Key? key})
      : super(key: key);

  final IconData _icon;
  final String _title;
  final Widget _innerWidget;
  final Function? _callback;

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends BaseScreenState<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: ColorRes.green),
            borderRadius: const BorderRadius.all(Radius.elliptical(10, 10))),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.only(left: 20, right: 20))),
            onPressed: () => widget._callback?.call(),
            child: Row(children: [
              Icon(widget._icon, color: ColorRes.green, size: 25.0),
              const Spacer(),
              Text(widget._title,
                  style: TextStyle(fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 20)),
              const Spacer(),
              widget._innerWidget
            ])));
  }
}
