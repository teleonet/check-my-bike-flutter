import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';

class DatabaseByNameScreen extends StatefulWidget {
  const DatabaseByNameScreen({Key? key}) : super(key: key);

  @override
  _DatabaseByNameScreenState createState() => _DatabaseByNameScreenState();
}

class _DatabaseByNameScreenState extends BaseScreenState<DatabaseByNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ))
    ]);
  }
}
