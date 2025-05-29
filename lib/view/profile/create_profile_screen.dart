import '../../core/utils/app_export.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
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
                  key: _formKey,
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
                        CustomTextField(
                          hintText: 'Full Name',
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Bio field
                        CustomTextField(
                          hintText: 'Bio',
                          controller: _bioController,
                          textInputAction: TextInputAction.next,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),

                        // Location field
                        CustomTextField(
                          hintText: 'Location',
                          controller: _locationController,
                          textInputAction: TextInputAction.done,
                          prefixIcon: const Icon(Icons.location_on_outlined,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Save button at the bottom of the screen
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 12.0),
                child: CustomButton(
                  text: 'Save Profile',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Show success message and navigate to home
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Profile created successfully!')),
                      );
                      Navigator.of(context)
                          .pushReplacementNamed(AppConstants.homeRoute);
                    }
                  },
                  width: double.infinity,
                  height: 50,
                  showShadow: true,
                  backgroundColor: const Color(0xFF039855),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  borderRadius: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
