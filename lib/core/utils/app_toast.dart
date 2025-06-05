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
        autoCloseDuration: const Duration(milliseconds: 1000),
        alignment: Alignment.topCenter,
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.always,
        animationDuration: const Duration(milliseconds: 500),
        closeButton: ToastCloseButton(
          showType: CloseButtonShowType.always,
        ));
  }
}

// Global navigator key for accessing context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
