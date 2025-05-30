import '../../core/utils/app_export.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0.w),
          child: CustomBackButton(),
        ),
        actions: [
          LanguageButton(),
        ],
        leadingWidth: 100.w,
        title: Text(Lang.of(context).profile,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.isSuccess) {
            // Show success message and navigate to home
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(Lang.of(context).profilecreatedsuccesfully),
                duration: const Duration(seconds: 1),
              ),
            );
            // Navigate to home screen
            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.of(context)
                  .pushReplacementNamed(AppConstants.homeRoute);
            });
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: Builder(builder: (context) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h),

                  // Profile picture
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF039855),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.w,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

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
                              final nameController =
                                  TextEditingController(text: state.name);
                              nameController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: nameController.text.length),
                              );
                              return CustomTextField(
                                hintText: Lang.of(context).fullName,
                                controller: nameController,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your name";
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
                          SizedBox(height: 16.h),

                          // Phone field
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.phone != current.phone,
                            builder: (context, state) {
                              final phoneController =
                                  TextEditingController(text: state.phone);
                              phoneController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: phoneController.text.length),
                              );
                              return CustomPhoneField(
                                controller: phoneController,
                                hintText: Lang.of(context).hintPhone,
                                countryCode: '+91',
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(PhoneChanged(value));
                                },
                              );
                            },
                          ),
                          SizedBox(height: 16.h),

                          // Email field
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.email != current.email,
                            builder: (context, state) {
                              final emailController =
                                  TextEditingController(text: state.email);
                              emailController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: emailController.text.length),
                              );
                              return CustomTextField(
                                hintText: Lang.of(context).hintEmail,
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
                          SizedBox(height: 16.h),

                          // Street field
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.street != current.street,
                            builder: (context, state) {
                              final streetController =
                                  TextEditingController(text: state.street);
                              streetController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: streetController.text.length),
                              );
                              return CustomTextField(
                                hintText: Lang.of(context).street,
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
                          SizedBox(height: 16.h),

                          // City dropdown
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.city != current.city ||
                                previous.cities != current.cities,
                            builder: (context, state) {
                              return CustomDropdownField(
                                hintText: Lang.of(context).city,
                                items: state.cities,
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
                          SizedBox(height: 16.h),

                          // District dropdown
                          BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.district != current.district ||
                                previous.districts != current.districts,
                            builder: (context, state) {
                              return CustomDropdownField(
                                hintText: Lang.of(context).district,
                                items: state.districts,
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
                    padding: EdgeInsets.symmetric(vertical: 16.0.h),
                    child: Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: CustomButton(
                            text: Lang.of(context).cancel,
                            onPressed: () => Navigator.pop(context),
                            isPrimary: false,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            borderColor: const Color(0xFF039855),
                            height: 50.h,
                            borderRadius: 8.r,
                          ),
                        ),
                        SizedBox(width: 16.w),

                        // Save button
                        Expanded(
                          child: BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) =>
                                previous.isSubmitting != current.isSubmitting ||
                                previous.name != current.name,
                            builder: (context, state) {
                              return CustomButton(
                                text: Lang.of(context).save,
                                onPressed: state.isSubmitting ||
                                        state.name.trim().isEmpty
                                    ? null
                                    : () {
                                        context
                                            .read<ProfileBloc>()
                                            .add(ProfileSubmitted());
                                      },
                                height: 50.h,
                                isLoading: state.isSubmitting,
                                backgroundColor: const Color(0xFF039855),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                borderRadius: 8.r,
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
