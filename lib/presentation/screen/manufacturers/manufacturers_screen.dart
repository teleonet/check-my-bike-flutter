import 'package:check_my_bike_flutter/presentation/screen/manufacturers/search/manufacturers_search_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/tab/manufacturers_tab_controller.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/base_screen_state.dart';
import 'all/manufacturers_all_screen.dart';
import 'favorites/manufacturers_favorites_screen.dart';

class ManufacturersScreen extends StatefulWidget {
  Function? _onTabClicked;
  Function? _onTopScroll;
  Function? _onBottomScroll;

  ManufacturersScreen(
      {Function? onTopScroll, Function? onBottomScroll, Function? onTabClicked, Key? key})
      : super(key: key) {
    _onTopScroll = onTopScroll;
    _onBottomScroll = onBottomScroll;
    _onTabClicked = onTabClicked;
  }

  @override
  _ManufacturersScreenState createState() => _ManufacturersScreenState();
}

class _ManufacturersScreenState extends BaseScreenState<ManufacturersScreen> {
  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      const Header("Manufacturers"),
      const Padding(padding: EdgeInsets.only(top: 5)),
      ManufacturersTabController(_buildScreens(), onTabClicked: () => widget._onTabClicked?.call())
    ]);
  }

  List<Widget> _buildScreens() {
    return [
      ManufacturersAllScreen(
          onTopScroll: widget._onTopScroll, onBottomScroll: widget._onBottomScroll),
      ManufacturersSearchScreen(
          onTopScroll: widget._onTopScroll, onBottomScroll: widget._onBottomScroll),
      ManufacturersFavoritesScreen(
          onTopScroll: widget._onTopScroll, onBottomScroll: widget._onBottomScroll)
    ];
  }
}
