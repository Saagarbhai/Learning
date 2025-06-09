# Learning App

A feature-rich Flutter application for e-learning platforms with multi-language support, clean architecture, and modern UI.

## 🚀 Features

### 🔐 Authentication
- Complete user authentication flow
- Sign up with email and password
- Sign in for existing users
- OTP verification
- Forgot password flow
- Profile creation
- Form validation for all inputs

### 🌐 Internationalization
- Multi-language support (English, Hindi, Gujarati)
- Easy language switching
- Localized content throughout the app

### 📱 UI/UX
- Engaging onboarding flow with animations
- Modern and clean UI design
- Responsive layouts using Flutter ScreenUtil
- Custom form components
- Loading indicators and feedback
- Toast notifications for user feedback

### 🏗️ Architecture
- BLoC pattern for state management
- Clean architecture with separation of concerns
- Repository pattern for data access
- API integration for backend services

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
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
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

# Generate native splash screens
flutter pub run flutter_native_splash:create

# Continuous code generation during development
flutter pub run build_runner watch
```

## 📦 Dependencies

- **State Management**: `flutter_bloc`, `bloc`, `equatable`
- **UI**: `flutter_screenutil`, `flutter_svg`, `pinput`, `percent_indicator`, `shimmer`, `toastification`
- **Networking**: `dio`, `http`, `pretty_dio_logger`
- **Storage**: `shared_preferences`
- **Localization**: `intl`, `flutter_localizations`
- **Media**: `image_picker`
- **Code Generation**: `build_runner`, `flutter_gen_runner`, `intl_utils`

## 🔄 App Flow

1. **Onboarding**: First-time users see onboarding screens
2. **Welcome**: Choose to sign up or sign in
3. **Authentication**: Register or login with form validation
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