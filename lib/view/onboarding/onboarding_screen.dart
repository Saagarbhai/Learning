import 'package:learning/core/utils/app_export.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a PageController that will be accessible throughout the widget
    final PageController pageController = PageController(initialPage: 0);

    // Initialize the onboarding state
    context.read<OnboardingBloc>().add(const OnboardingPageChanged(0));

    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingFinished) {
          // Navigate to home screen without animation when coming from last page
          Navigator.of(context).pushReplacementNamed(
            AppConstants.welcomeRoute,
            result: false,
          );
        } else if (state is OnboardingInProgress) {
          // Animate to the new page when state changes
          if (pageController.hasClients &&
              state.currentPage != pageController.page?.round()) {
            pageController.animateToPage(
              state.currentPage,
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastEaseInToSlowEaseOut,
            );
          }
        }
      },
      builder: (context, state) {
        int currentPage = 0;
        if (state is OnboardingInProgress) {
          currentPage = state.currentPage;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              Lang.of(context).apptitle,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<OnboardingBloc>().add(const OnboardingSkipped());
                },
                child: Text(
                  Lang.of(context).skip,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16.sp,
                  ),
                ),
              )
            ],
            // Language button on the left side
            leading: const LanguageButton(),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    context
                        .read<OnboardingBloc>()
                        .add(OnboardingPageChanged(index));
                  },
                  children: [
                    _buildPage(
                        image: Assets.images.onbordingImageSvg.onbording1.path,
                        title: Lang.of(context).onboardingData1Title,
                        description:
                            Lang.of(context).onboardingData1Description),
                    _buildPage(
                      image: Assets.images.onbordingImageSvg.onbording2.path,
                      title: Lang.of(context).onboardingData2Title,
                      description: Lang.of(context).onboardingData2Description,
                    ),
                    _buildPage(
                      image: Assets.images.onbordingImageSvg.onbording3.path,
                      title: Lang.of(context).onboardingData3Title,
                      description: Lang.of(context).onboardingData3Description,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 100.h),
                child: Container(
                  height: 100.h,
                  alignment: Alignment.center,
                  child: CircularProgressButton(
                    size: 80,
                    onPressed: () {
                      if (currentPage < OnboardingBloc.totalPages - 1) {
                        // Simply add the NextPageEvent to handle page transition
                        context.read<OnboardingBloc>().add(NextPageEvent());
                      } else {
                        // This is the last page, complete onboarding
                        context
                            .read<OnboardingBloc>()
                            .add(const OnboardingCompleted());
                      }
                    },
                    showGoText: currentPage == 2 ? true : false,
                    pageIndex: currentPage,
                    navigateDirectlyToWelcome: true,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: 220.h,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 220.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.directions_car,
                  size: 100.sp,
                  color: Colors.green[400],
                ),
              );
            },
          ),
          SizedBox(height: 40.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
