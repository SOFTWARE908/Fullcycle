import 'package:flutter/material.dart';

import '../../services/navigation/navigation.dart';

class CustomSnackBars {
  static void showSuccessToast({required String title}) {
    ScaffoldMessenger.of(AppNavigation.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
      content: Text(title),
      backgroundColor: Colors.green,
    ));
  }

  static void showErrorToast({required String title}) {
    ScaffoldMessenger.of(AppNavigation.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
      content: Text(title),
      backgroundColor: Colors.red,
    ));
  }
}
