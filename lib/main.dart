import 'core/utils/app_export.dart';

void main() {
  runApp(
    ToastificationWrapper(
      // ToastificationWrapper is a widget that wraps the app and provides a toastification context
      child: MyApp(),
    ),
  );
}
