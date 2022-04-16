import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';

class DatabaseTabItem extends StatefulWidget {
  final String _title;

  const DatabaseTabItem(this._title, {Key? key}) : super(key: key);

  @override
  _DatabaseTabItemState createState() => _DatabaseTabItemState();
}

class _DatabaseTabItemState extends BaseScreenState<DatabaseTabItem> {
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
