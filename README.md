### Environment

- Flutter 3.7.12 • channel stable • https://github.com/flutter/flutter.git
- Tools • Dart 2.17.6 • DevTools 2.12.2

### Android/iOS version

- Android
    - compileSdkVersion: 33
    - minSdkVersion 21
    - targetSdkVersion 31
- iOS:
    - deployment info: iOS 12.0

### Build setup

``` bash
# Sync package dependency
$ flutter pub get
# Generate files for packages
$ flutter pub run build_runner build --delete-conflicting-outputs

# Injectable
# Use the [watch] flag to watch the files' system for edits and rebuild as necessary.
$ flutter pub run build_runner watch --delete-conflicting-outputs
```

### Build

#### Flavors

- **Production**
- **Staging** ~ For test before release.
- **Development** ~ For development purpose.

``` bash
# To run development flavor
$ flutter run --flavor dev -t lib/main_dev.dart

# To run Staging flavor
$ flutter run --flavor stag -t lib/main_stag.dart

# To run Production flavor
$ flutter run --flavor prod -t lib/main_prod.dart

# -------
# Android Development
$ flutter build apk --release --flavor dev -t lib/main_dev.dart

# iOS Development
$ flutter build ios --release --flavor dev --no-codesign -t lib/main_dev.dart
$ flutter build ipa --release --flavor dev -t lib/main_dev.dart

# --------

# Android Staging
$ flutter build apk --release --flavor stag -t lib/main_stag.dart

# iOS Staging
$ flutter build ios --release --flavor stag --no-codesign -t lib/main_stag.dart
$ flutter build ipa --release --flavor stag -t lib/main_stag.dart

# --------

# Android Production
$ flutter build apk --release --flavor prod -t lib/main_prod.dart

# iOS Production
$ flutter build ios --release --flavor prod --no-codesign -t lib/main_prod.dart
$ flutter build ipa --release --flavor prod -t lib/main_prod.dart
