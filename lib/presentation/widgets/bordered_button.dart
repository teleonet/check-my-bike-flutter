import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';

class BorderedButton extends StatefulWidget {
  final String _title;
  final Function? onPressed;

  const BorderedButton(this._title, {this.onPressed, Key? key}) : super(key: key);

  @override
  BorderedButtonState createState() => BorderedButtonState();
}

class BorderedButtonState extends State<BorderedButton> {
  Color _decorationColor = ColorsRes.green;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        decoration: _buildButtonDecoration(),
        width: MediaQuery.of(context).size.width,
        child: _buildTextButton());
  }

  Decoration _buildButtonDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: _decorationColor, width: 0.3),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  TextButton _buildTextButton() {
    return TextButton(
        onPressed: () {
          changeToNormalState();
          widget.onPressed?.call();
        },
        child: _buildText());
  }

  Text _buildText() {
    return Text(widget._title, textAlign: TextAlign.center, style: _buildTextStyle());
  }

  TextStyle _buildTextStyle() {
    return TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20);
  }

  void changeToNormalState() {
    _decorationColor = ColorsRes.green;
    setState(() => {});
  }

  void changeToErrorState() {
    _decorationColor = Colors.red;
    setState(() => {});
  }
}
