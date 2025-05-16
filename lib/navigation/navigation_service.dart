import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Push a new route and remove all previous ones
  void pushAndRemoveUntil(Widget page) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (Route<dynamic> route) => false,
    );
  }

  /// Replace current route with a new one
  void pushReplacement(Widget page) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Push a new route
  void push(Widget page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Pop the current route
  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
