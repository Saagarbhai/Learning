import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  // Add a timestamp to track the last toast shown
  static DateTime? _lastToastTime;
  static const _debounceTime = Duration(milliseconds: 300);

  static void show({
    required String message,
    required ToastificationType type,
  }) {
    // Check if we should show the toast based on debounce time
    final now = DateTime.now();
    if (_lastToastTime != null &&
        now.difference(_lastToastTime!) < _debounceTime) {
      // Skip this toast as it's too close to the previous one
      return;
    }

    // Update the last toast time
    _lastToastTime = now;

    toastification.show(
        context: navigatorKey.currentContext!,
        title: Text(message),
        type: type,
        style: ToastificationStyle.flatColored,
        autoCloseDuration: const Duration(milliseconds: 1700),
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
