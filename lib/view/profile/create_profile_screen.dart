import '../../core/utils/app_export.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppConstants.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: const Text("Back",
              style: TextStyle(color: Colors.black, fontSize: 16)),
          titleSpacing: 0,
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Show success message and navigate to home
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile created successfully!'),
                  duration: Duration(seconds: 1),
                ),
              );
              // Navigate to home screen
              Future.delayed(const Duration(milliseconds: 500), () {
                _navigateToHome(context);
              });
            }
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          child: Builder(builder: (context) {
            // Create controllers for each field
            final nameController = TextEditingController();
            final bioController = TextEditingController();
            final locationController = TextEditingController();

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Header text
                    const Text(
                      'Create Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Complete your profile details',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Profile form
                    Expanded(
                      child: Form(
                        key: GlobalKey<FormState>(),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile picture
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF039855),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Name field
                              BlocBuilder<ProfileBloc, ProfileState>(
                                buildWhen: (previous, current) =>
                                    previous.name != current.name,
                                builder: (context, state) {
                                  nameController.text = state.name;
                                  nameController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: nameController.text.length));
                                  return CustomTextField(
                                    hintText: 'Full Name',
                                    controller: nameController,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      context
                                          .read<ProfileBloc>()
                                          .add(NameChanged(value));
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 16),

                              // Bio field
                              BlocBuilder<ProfileBloc, ProfileState>(
                                buildWhen: (previous, current) =>
                                    previous.bio != current.bio,
                                builder: (context, state) {
                                  bioController.text = state.bio;
                                  bioController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: bioController.text.length));
                                  return CustomTextField(
                                    hintText: 'Bio',
                                    controller: bioController,
                                    textInputAction: TextInputAction.next,
                                    maxLines: 3,
                                    onChanged: (value) {
                                      context
                                          .read<ProfileBloc>()
                                          .add(BioChanged(value));
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 16),

                              // Location field
                              BlocBuilder<ProfileBloc, ProfileState>(
                                buildWhen: (previous, current) =>
                                    previous.location != current.location,
                                builder: (context, state) {
                                  locationController.text = state.location;
                                  locationController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              locationController.text.length));
                                  return CustomTextField(
                                    hintText: 'Location',
                                    controller: locationController,
                                    textInputAction: TextInputAction.done,
                                    prefixIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey),
                                    onChanged: (value) {
                                      context
                                          .read<ProfileBloc>()
                                          .add(LocationChanged(value));
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Save button at the bottom of the screen
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0, top: 12.0),
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        buildWhen: (previous, current) =>
                            previous.isSubmitting != current.isSubmitting ||
                            previous.name != current.name,
                        builder: (context, state) {
                          return CustomButton(
                            text: 'Save Profile',
                            onPressed:
                                state.isSubmitting || state.name.trim().isEmpty
                                    ? null
                                    : () {
                                        context
                                            .read<ProfileBloc>()
                                            .add(ProfileSubmitted());
                                      },
                            width: double.infinity,
                            height: 50,
                            isLoading: state.isSubmitting,
                            showShadow: true,
                            backgroundColor: state.name.trim().isNotEmpty
                                ? const Color(0xFF039855)
                                : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            borderRadius: 8,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
