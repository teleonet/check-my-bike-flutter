import 'package:check_my_bike_flutter/presentation/screen/widgets/input_form.dart';
import 'package:flutter/material.dart';

import '../../../validator/validator.dart';
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
      InputForm("Manufacturer's name", (text) => print("pressed find by name: $text"), (text) {
        return Validator.moreThenOneSymbol(text);
      }, "Please enter more then 1 symbols")
    ]);
  }
}
