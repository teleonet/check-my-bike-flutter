import 'package:check_my_bike_flutter/resources/colors_res.dart';
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
          margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
          child: TextFormField(
              maxLines: 1,
              cursorColor: ColorsRes.green,
              autofocus: false,
              style: TextStyle(color: ColorsRes.green, fontFamily: 'Roboto Thin'),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: ColorsRes.green),
                labelText: "Manufacturer's name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: ColorsRes.green, width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: ColorsRes.darkGreen, width: 0.5),
                ),
              )))
    ]);
  }
}
