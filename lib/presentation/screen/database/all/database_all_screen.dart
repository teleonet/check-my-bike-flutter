import 'package:check_my_bike_flutter/presentation/screen/widgets/header.dart';
import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';

class DatabaseAllScreen extends StatefulWidget {
  const DatabaseAllScreen({Key? key}) : super(key: key);

  @override
  _DatabaseAllScreenState createState() => _DatabaseAllScreenState();
}

class _DatabaseAllScreenState extends BaseScreenState<DatabaseAllScreen> {
  @override
  Widget build(BuildContext context) {
    return const Header("All");
  }
}
