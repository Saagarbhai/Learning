import '../../core/utils/app_export.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppConstants.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CustomBackButton(),
        ),
        leadingWidth: 100,
        title: const Text("Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
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
          final phoneController = TextEditingController();
          final emailController = TextEditingController();
          final streetController = TextEditingController();

          // City and district fields will use the dropdown
          final cities = ['Dhaka', 'Chittagong', 'Khulna', 'Rajshahi'];
          final districts = ['Dhaka', 'Chittagong', 'Khulna', 'Rajshahi'];

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

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
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 32,
                            height: 32,
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
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Form fields
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Full Name field
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

                          // Phone field
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.phone != current.phone,
                            builder: (context, state) {
                              phoneController.text = state.phone;
                              phoneController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: phoneController.text.length));
                              return CustomPhoneField(
                                controller: phoneController,
                                hintText: 'Your mobile number',
                                countryCode: '+880',
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(PhoneChanged(value));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Email field
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.email != current.email,
                            builder: (context, state) {
                              emailController.text = state.email;
                              emailController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: emailController.text.length));
                              return CustomTextField(
                                hintText: 'Email',
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(EmailChanged(value));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Street field
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.street != current.street,
                            builder: (context, state) {
                              streetController.text = state.street;
                              streetController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: streetController.text.length));
                              return CustomTextField(
                                hintText: 'Street',
                                controller: streetController,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(StreetChanged(value));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // City dropdown
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.city != current.city,
                            builder: (context, state) {
                              return CustomDropdownField(
                                hintText: 'City',
                                items: cities,
                                value: state.city.isEmpty ? null : state.city,
                                onChanged: (value) {
                                  if (value != null) {
                                    context
                                        .read<ProfileBloc>()
                                        .add(CityChanged(value));
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // District dropdown
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.district != current.district,
                            builder: (context, state) {
                              return CustomDropdownField(
                                hintText: 'District',
                                items: districts,
                                value: state.district.isEmpty
                                    ? null
                                    : state.district,
                                onChanged: (value) {
                                  if (value != null) {
                                    context
                                        .read<ProfileBloc>()
                                        .add(DistrictChanged(value));
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Buttons at the bottom
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: CustomButton(
                            text: 'Cancel',
                            onPressed: () => Navigator.pop(context),
                            isPrimary: false,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            borderColor: Colors.grey[300],
                            height: 50,
                            borderRadius: 8,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Save button
                        Expanded(
                          child: BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.isSubmitting != current.isSubmitting ||
                                previous.name != current.name,
                            builder: (context, state) {
                              return CustomButton(
                                text: 'Save',
                                onPressed: state.isSubmitting ||
                                        state.name.trim().isEmpty
                                    ? null
                                    : () {
                                        context
                                            .read<ProfileBloc>()
                                            .add(ProfileSubmitted());
                                      },
                                height: 50,
                                isLoading: state.isSubmitting,
                                backgroundColor: const Color(0xFF039855),
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
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
