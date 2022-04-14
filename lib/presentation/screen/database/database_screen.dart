import 'package:check_my_bike_flutter/presentation/screen/widgets/header.dart';
import 'package:flutter/cupertino.dart';

import '../base/base_screen_state.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({Key? key}) : super(key: key);

  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends BaseScreenState<DatabaseScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(children: const [Header("Database"), Spacer()]));
  }
}
