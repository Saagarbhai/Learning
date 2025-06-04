import '../../core/utils/app_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load user data when screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(LoadUserData());
    });

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeInitial) {
          // After logout, navigate to welcome screen
          Navigator.of(context).pushReplacementNamed(AppConstants.welcomeRoute);
        } else if (state is HomeError) {
          // Show error message
          AppToast.show(
            message: state.message,
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(Lang.of(context).apptitle),
            actions: [
              LanguageButton(),
            ],
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // User Profile Image
                  if (state.userImage.isNotEmpty)
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(state.userImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 50.w,
                        color: Colors.grey[600],
                      ),
                    ),
                  SizedBox(height: 16.h),

                  // User Name
                  Text(
                    'Welcome, ${state.userName}!',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // User Email
                  Text(
                    state.userEmail,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Logout Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: CustomButton(
                      text: Lang.of(context).logout,
                      onPressed: () {
                        // Show success message before dispatching logout event
                        AppToast.show(
                          message: 'Logged out successfully',
                          type: ToastificationType.success,
                        );

                        // Dispatch logout event
                        context.read<HomeBloc>().add(LogoutUser());
                      },
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
