import '../../core/utils/app_export.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onLoadLanguage(
    LoadLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('languageCode') ?? 'en';
      emit(LanguageLoaded(Locale(languageCode)));
    } catch (e) {
      emit(LanguageError(e.toString()));
      emit(const LanguageLoaded(Locale('en')));
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', event.languageCode);
      emit(LanguageLoaded(Locale(event.languageCode)));
    } catch (e) {
      emit(LanguageError(e.toString()));
    }
  }
}
