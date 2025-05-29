import '../../core/utils/app_export.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final Locale locale;

  const LanguageLoaded(this.locale);

  @override
  List<Object> get props => [locale];
}

class LanguageLoading extends LanguageState {}

class LanguageError extends LanguageState {
  final String message;

  const LanguageError(this.message);

  @override
  List<Object> get props => [message];
}

class LanguageChanged extends LanguageState {
  final String languageCode;

  const LanguageChanged(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
