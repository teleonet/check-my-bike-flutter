import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';

class ManufacturersTabItem extends StatefulWidget {
  final String _title;

  const ManufacturersTabItem(this._title, {Key? key}) : super(key: key);

  @override
  _ManufacturersTabItemState createState() => _ManufacturersTabItemState();
}

class _ManufacturersTabItemState extends BaseScreenState<ManufacturersTabItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Center(
            child: Text(
          widget._title,
          textAlign: TextAlign.center,
        )));
  }
}
