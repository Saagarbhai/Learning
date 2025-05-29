import 'package:learning/core/utils/app_export.dart';

extension AppLocalizationsX on BuildContext {
  Lang? get l10n => Lang.of(this);
}

// Add all localization delegates here
final List<LocalizationsDelegate<dynamic>> localizationDelegates = [
  Lang.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
