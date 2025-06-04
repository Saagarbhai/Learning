import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void show({
    required String message,
    required ToastificationType type,
  }) {
    toastification.show(
      context: navigatorKey.currentContext!,
      title: Text(message),
      type: type,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}

// Global navigator key for accessing context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
