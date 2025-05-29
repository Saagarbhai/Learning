import '../../core/utils/app_export.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LoadLanguage extends LanguageEvent {
  const LoadLanguage();
}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;

  const ChangeLanguage(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
