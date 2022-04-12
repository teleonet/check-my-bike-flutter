import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

abstract class BaseScreenState<T extends StatefulWidget> extends State<T> {
  // Bloc? bloc;

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // bloc?.onResume();
    });
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
