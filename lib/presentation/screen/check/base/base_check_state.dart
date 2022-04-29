import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';

abstract class BaseCheckState<T extends StatefulWidget> extends BaseScreenState<T> {
  final String _title;

  BaseCheckState(this._title);

  @protected
  List<Widget> getWidgets();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: _buildGradientDecoration(),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _buildAppBar(),
          const Padding(padding: EdgeInsets.only(top: 5)),
          Column(children: getWidgets()),
          const Spacer(),
          Container(height: 15, decoration: _buildBottomDecoration())
        ]));
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: _buildAppBarBorder(),
      title: Text(_title),
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
      titleTextStyle: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 35),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsRes.green, size: 25.0),
          onPressed: () => Navigator.pop(context)),
    );
  }

  OutlinedBorder _buildAppBarBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)));
  }

  Decoration _buildBottomDecoration() {
    return BoxDecoration(
        border: Border.all(width: 0.4, color: ColorsRes.green),
        borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)));
  }
}
