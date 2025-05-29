import '../../core/utils/app_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(Lang.of(context).apptitle),
          ),
          body: Center(
            child: Text(Lang.of(context).onboardingData1Title),
          ),
        );
      },
    );
  }
}
