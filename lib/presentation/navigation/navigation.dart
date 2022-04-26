import 'package:flutter/material.dart';

class Navigation {
  static final Navigation _instance = Navigation._internal();

  factory Navigation() {
    return _instance;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Navigation._internal();

  Future<void>? push(String routeName) {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  Future<void>? pushAndReplace(String routeName) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void pop() {
    return navigatorKey.currentState?.pop();
  }
}
