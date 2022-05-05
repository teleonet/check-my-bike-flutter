import 'package:check_my_bike_flutter/presentation/screen/manufacturers/search/manufacturers_search_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/tab/sliver_manufacturers_tab_controller.dart';
import 'package:check_my_bike_flutter/presentation/scroll/scroll_controller_with_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';
import '../../widgets/header.dart';
import 'all/manufacturers_all_screen.dart';
import 'favorites/manufacturers_favorites_screen.dart';

class ManufacturersScreen extends StatefulWidget {
  final Function? onScrollTop;
  final Function? onScrollBottom;
  final Function? onScrolledTop;
  final Function? onScrolledBottom;
  final Function? onClickedTab;

  const ManufacturersScreen(
      {this.onScrollTop,
      this.onScrollBottom,
      this.onScrolledTop,
      this.onScrolledBottom,
      this.onClickedTab,
      Key? key})
      : super(key: key);

  @override
  _ManufacturersScreenState createState() => _ManufacturersScreenState();
}

class _ManufacturersScreenState extends BaseScreenState<ManufacturersScreen> {
  List<Widget> _screens = [];
  Widget _currentScreen = const SizedBox.shrink();
  ScrollControllerWithListener? _scrollController;
  final GlobalKey<SliverManufacturersTabControllerState> _tabControllerKey =
      GlobalKey<SliverManufacturersTabControllerState>();

  @override
  void initState() {
    _screens = _buildScreens();
    _currentScreen = _screens[0];

    _initScrollController();

    super.initState();
  }

  List<Widget> _buildScreens() {
    return const [
      ManufacturersAllScreen(),
      ManufacturersSearchScreen(),
      ManufacturersFavoritesScreen()
    ];
  }

  void _initScrollController() {
    _scrollController = ScrollControllerWithListener(
        onScrollTop: () => widget.onScrollTop?.call(),
        onScrollBottom: () {
          widget.onScrollBottom?.call();
          _tabControllerKey.currentState?.changeToScrollColor();
        },
        onScrolledTop: () {
          widget.onScrolledTop?.call();
          _tabControllerKey.currentState?.changeToDefaultColor();
        },
        onScrolledBottom: () => widget.onScrolledBottom?.call());
    _scrollController?.initListener();
  }

  @override
  void dispose() {
    _scrollController?.disposeListener();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: _buildGradientDecoration(),
        child: CustomScrollView(controller: _scrollController, slivers: [
          const SliverToBoxAdapter(child: Header("Manufacturers")),
          _buildTabController(),
          _currentScreen
        ]));
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  Widget _buildTabController() {
    return SliverManufacturersTabController(
        (index) => setState(() {
              widget.onClickedTab?.call();
              _currentScreen = _screens[index];
            }),
        key: _tabControllerKey);
  }
}
