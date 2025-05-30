import '../../core/utils/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add the SplashStarted event when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SplashBloc>(context).add(const SplashStarted());
    });

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          Navigator.of(context)
              .pushReplacementNamed(AppConstants.onboardingRoute);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF08B783),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Center(
              child: Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 20.r,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.directions_car,
                  size: 70.sp,
                  color: Color(0xFF08B783),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
