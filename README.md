# learning

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

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