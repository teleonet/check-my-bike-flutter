import 'package:check_my_bike_flutter/presentation/screen/widgets/header.dart';
import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';

class DatabaseByName extends StatefulWidget {
  const DatabaseByName({Key? key}) : super(key: key);

  @override
  _DatabaseByNameState createState() => _DatabaseByNameState();
}

class _DatabaseByNameState extends BaseScreenState<DatabaseByName> {
  @override
  Widget build(BuildContext context) {
    return const Header("By Name");
  }
}
