import 'package:check_my_bike_flutter/presentation/screen/manufacturers/search/manufacturers_search_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/tab/manufacturers_tab_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';
import '../../widgets/header.dart';
import 'all/manufacturers_all_screen.dart';
import 'favorites/manufacturers_favorites_screen.dart';

class ManufacturersScreen extends StatefulWidget {
  final Function? onClickedTab;
  final Function? onScrollTop;
  final Function? onScrollBottom;

  const ManufacturersScreen({this.onScrollTop, this.onScrollBottom, this.onClickedTab, Key? key})
      : super(key: key);

  @override
  _ManufacturersScreenState createState() => _ManufacturersScreenState();
}

class _ManufacturersScreenState extends BaseScreenState<ManufacturersScreen> {
  List<Widget> _screens = [];
  Widget? _currentScreen;

  @override
  void initState() {
    _screens = _buildScreens();
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      ManufacturersAllScreen(
          onScrollTop: widget.onScrollTop, onScrollBottom: widget.onScrollBottom),
      ManufacturersSearchScreen(
          onScrollTop: widget.onScrollTop, onScrollBottom: widget.onScrollBottom),
      ManufacturersFavoritesScreen(
          onScrollTop: widget.onScrollTop, onScrollBottom: widget.onScrollBottom)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      const Header("Manufacturers"),
      const Padding(padding: EdgeInsets.only(top: 5)),
      ManufacturersTabController((index) => setState(() {
            widget.onClickedTab?.call();
            _currentScreen = _screens[index];
          })),
      Container(child: _currentScreen ?? _screens[0])
    ]);
  }
}
