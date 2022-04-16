import 'package:check_my_bike_flutter/presentation/screen/widgets/header.dart';
import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';

class DatabaseAll extends StatefulWidget {
  const DatabaseAll({Key? key}) : super(key: key);

  @override
  _DatabaseAllState createState() => _DatabaseAllState();
}

class _DatabaseAllState extends BaseScreenState<DatabaseAll> {
  @override
  Widget build(BuildContext context) {
    return const Header("All");
  }
}
