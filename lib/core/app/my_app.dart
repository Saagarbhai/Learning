import 'package:learning/core/utils/app_export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(
          create: (context) => LanguageBloc()..add(const LoadLanguage()),
        ),
        BlocProvider(create: (context) => OnboardingBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => OtpVerificationBloc()),
        BlocProvider(create: (context) => PasswordBloc()),
        BlocProvider(create: (context) => WelcomeBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => SignInBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          final locale =
              state is LanguageLoaded ? state.locale : const Locale('en');

          return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                title: AppConstants.appName,
                themeMode: ThemeMode.system,
                locale: locale,
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('hi'), // Hindi
                  Locale('gu'), // Gujarati
                ],
                localizationsDelegates: localizationDelegates,
                onGenerateRoute: AppRouter.generateRoute,
                initialRoute: AppConstants.splashRoute,
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
