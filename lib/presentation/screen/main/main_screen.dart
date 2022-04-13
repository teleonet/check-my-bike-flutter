import 'package:check_my_bike_flutter/presentation/screen/database/database_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_screen.dart';
import 'package:check_my_bike_flutter/resources/color_res.dart';
import 'package:flutter/material.dart';

import '../base/base_screen_state.dart';
import '../check/check_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreenState<MainScreen> {
  int _updatedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ColorRes.startGradient, ColorRes.endGradient])),
          child: IndexedStack(
            index: _updatedIndex,
            children: _buildScreens(),
          ),
        ));
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: Container(
            height: 80,
            color: ColorRes.endGradient,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Align(
                  alignment: _getBottomNavigationLIneAlignment(_updatedIndex),
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    height: 1,
                    width: MediaQuery.of(context).size.width / 3.7,
                    color: ColorRes.green,
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: BottomNavigationBar(
                      currentIndex: _updatedIndex,
                      onTap: (index) {
                        setState(() {
                          _updatedIndex = index;
                        });
                      },
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      unselectedIconTheme: const IconThemeData(color: Colors.white, size: 30),
                      unselectedLabelStyle:
                          const TextStyle(fontFamily: 'Roboto Thin', fontSize: 14),
                      unselectedItemColor: Colors.white,
                      selectedItemColor: ColorRes.green,
                      selectedIconTheme: IconThemeData(color: ColorRes.green, size: 30),
                      selectedLabelStyle: const TextStyle(fontFamily: 'Roboto Thin', fontSize: 14),
                      items: _buildBottomNavigationBarItems()))
            ])));
  }

  Alignment _getBottomNavigationLIneAlignment(int index) {
    Alignment alignment = Alignment.center;
    switch (index) {
      case 0:
        alignment = Alignment.centerLeft;
        break;
      case 2:
        alignment = Alignment.centerRight;
        break;
    }
    return alignment;
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'check', tooltip: ""),
      BottomNavigationBarItem(icon: Icon(Icons.summarize), label: 'database', tooltip: ""),
      BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'settings', tooltip: ""),
    ];
  }

  List<Widget> _buildScreens() {
    return <Widget>[const CheckScreen(), const DatabaseScreen(), const SettingsScreen()];
  }
}
