# Learning App

A feature-rich Flutter application for e-learning platforms with multi-language support, clean architecture, and modern UI design.

![Flutter Version](https://img.shields.io/badge/Flutter-≥3.0.0-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-≥3.0.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 📱 Overview

Learning App is a modern mobile application built with Flutter that provides a comprehensive e-learning experience. The app features a complete authentication flow, multi-language support, and a clean, intuitive user interface designed with the latest UI/UX principles.

## 🚀 Features

### 🔐 Authentication
- Complete user authentication flow
- Sign up with email and password
- Sign in for existing users
- OTP verification
- Forgot password flow
- Profile creation with image upload
- Form validation for all inputs

### 🌐 Internationalization
- Multi-language support (English, Hindi, Gujarati)
- Easy language switching within the app
- Localized content throughout the application

### 📱 UI/UX
- Engaging onboarding flow with animations
- Modern and clean UI design
- Responsive layouts using Flutter ScreenUtil
- Custom form components and widgets
- Loading indicators and progress feedback
- Toast notifications for user interactions

### 🏗️ Architecture
- BLoC pattern for state management
- Clean architecture with separation of concerns
- Repository pattern for data access
- API integration for backend services
- Modular code organization

## 📂 Project Structure

```
lib/
├── core/             # Core functionality
│   ├── api_config/   # API configuration and client
│   ├── app/          # App initialization
│   ├── constants/    # App constants
│   ├── flavorconfig/ # Environment configuration
│   ├── generated/    # Generated code (assets, localization)
│   ├── l10n/         # Localization files
│   ├── routes/       # App routing
│   ├── theme/        # App theming
│   └── utils/        # Utility functions
├── model/            # Data models
├── repository/       # Data repositories
├── view/             # UI components
│   ├── forgot_password/
│   ├── home/
│   ├── onboarding/
│   ├── otp/
│   ├── password/
│   ├── profile/
│   ├── signin/
│   ├── signup/
│   ├── welcome/
│   └── widgets/      # Reusable widgets
├── viewmodel/        # BLoC state management
│   ├── forgot_password/
│   ├── home/
│   ├── language/
│   ├── onboarding/
│   ├── otp/
│   ├── password/
│   ├── profile/
│   ├── signin/
│   ├── signup/
│   └── welcome/
└── main.dart         # Application entry point
```

## 🔧 Development Setup

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Android / iOS Emulator

### Getting Started
1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/learning-app.git
   cd learning-app
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Run the app
   ```bash
   flutter run
   ```

### Code Generation
```bash
# Generate code and delete conflicting outputs
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes and continuously generate code
flutter pub run build_runner watch --delete-conflicting-outputs

# Generate asset classes with flutter_gen
flutter pub run build_runner build

# Generate localization files
flutter pub run intl_utils:generate
```

## 📦 Dependencies

### State Management
- `flutter_bloc` (^9.1.1): BLoC pattern implementation
- `bloc` (^9.0.0): Core BLoC library
- `equatable` (^2.0.5): Equality comparisons

### UI Components
- `flutter_screenutil` (^5.9.0): Responsive UI
- `flutter_svg` (^2.1.0): SVG rendering
- `pinput` (^5.0.1): PIN input fields
- `percent_indicator` (^4.2.5): Progress indicators
- `shimmer` (^3.0.0): Loading effects
- `toastification` (^3.0.2): Toast messages

### Networking
- `dio` (^5.4.0): HTTP client
- `http` (^1.1.0): HTTP requests
- `pretty_dio_logger` (^1.3.1): Network logging

### Storage
- `shared_preferences` (^2.2.2): Local storage

### Localization
- `intl` (^0.19.0): Internationalization
- `flutter_localizations`: Flutter localization

### Media
- `image_picker` (^1.0.4): Image selection

### Development
- `build_runner` (^2.4.15): Code generation
- `flutter_gen_runner` (^5.10.0): Asset generation
- `intl_utils` (^2.8.10): Localization utilities
- `flutter_lints` (^5.0.0): Linting rules
- `flutter_launcher_icons` (^0.14.3): App icon generation

## 🔄 App Flow

1. **Onboarding**: First-time users see engaging onboarding screens
2. **Welcome**: Choose to sign up or sign in
3. **Authentication**: Register or login with email/password
4. **Verification**: OTP verification for new accounts
5. **Profile Creation**: Set up user profile with picture
6. **Home**: Main app experience after authentication
7. **Settings**: Language selection and other preferences

## 🎨 UI Components

- Custom buttons with loading states
- Form fields with validation
- Custom dropdown components
- OTP input fields
- Social sign-in buttons
- Toast notifications
- Image pickers
- Language selection
- Progress indicators

## 🔐 Security Features

- Secure password handling
- OTP verification
- Form validation
- Secure API communication

## 🌐 Backend Integration

- REST API integration using Dio
- Repository pattern for data access
- API client configuration
- Error handling and response parsing

## 📱 Supported Platforms

- Android
- iOS
- Web (partial support)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Contact

Project Link: [https://github.com/yourusername/learning-app](https://github.com/yourusername/learning-app)

---

Built with ❤️ using Flutter