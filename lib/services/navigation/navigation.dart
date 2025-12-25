import 'package:flutter/material.dart';

class AppNavigation {
  static void push(Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));

  static void pushReplacment(Widget page) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));

  static void pop() => Navigator.of(context).pop();

  static void pushRemoveAll(Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
}
