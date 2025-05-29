import '../../core/utils/app_export.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(Lang.of(context).back,
            style: const TextStyle(color: Colors.black, fontSize: 16)),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocListener<PasswordBloc, PasswordState>(
            listener: (context, state) {
              if (state.isSuccess) {
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password set successfully!')),
                );
                // Navigate to create profile screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateProfileScreen(),
                  ),
                );
              }
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Header text
                const Text(
                  'Set password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Set your password',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 32),
                // Password fields
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Password field
                        BlocBuilder<PasswordBloc, PasswordState>(
                          buildWhen: (previous, current) =>
                              previous.password != current.password,
                          builder: (context, state) {
                            return CustomPasswordField(
                              hintText: 'Enter Your Password',
                              isValid: state.isPasswordValid,
                              onChanged: (value) {
                                context
                                    .read<PasswordBloc>()
                                    .add(PasswordChanged(value));
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        // Confirm password field
                        BlocBuilder<PasswordBloc, PasswordState>(
                          buildWhen: (previous, current) =>
                              previous.confirmPassword !=
                                  current.confirmPassword ||
                              previous.isConfirmPasswordValid !=
                                  current.isConfirmPasswordValid,
                          builder: (context, state) {
                            return CustomPasswordField(
                              hintText: 'Confirm Password',
                              confirmField: true,
                              isConfirmMatch: state.isConfirmPasswordValid,
                              onChanged: (value) {
                                context
                                    .read<PasswordBloc>()
                                    .add(ConfirmPasswordChanged(value));
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        // Password requirements text
                        const Text(
                          'Atleast 1 number or a special character',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Register button at the bottom of the screen
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, top: 12.0),
                  child: BlocBuilder<PasswordBloc, PasswordState>(
                    buildWhen: (previous, current) =>
                        previous.isPasswordValid != current.isPasswordValid ||
                        previous.isConfirmPasswordValid !=
                            current.isConfirmPasswordValid ||
                        previous.isSubmitting != current.isSubmitting,
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Register',
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                context
                                    .read<PasswordBloc>()
                                    .add(PasswordSubmitted());
                              },
                        width: double.infinity,
                        height: 50,
                        isLoading: state.isSubmitting,
                        showShadow: true,
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
        ),
      ),
    );
  }
}
