# Quick Start: How to Build the Release APK

## Prerequisites
- Flutter SDK (>= 3.0.0)
- Android Studio with Android SDK Command Line Tools
- Java JDK 17

## 3 Commands to Build APK:
```bash
cd student_marks_viewer
flutter pub get
flutter build apk --release
```

## Locate the Generated APK:
```bash
student_marks_viewer/build/app/outputs/flutter-apk/app-release.apk
```

## How to Install APK on Your Android Device:
1. Copy 'app-release.apk' to your phone via USB cable, Google Drive, or WhatsApp.
2. On your phone, open Files / Downloads and tap on 'app-release.apk'.
3. If prompted, allow "Install unknown apps" in Settings.
4. Tap Install and open the app!

## Method 2: Free Automated Cloud Build via GitHub Actions
We have included '.github/workflows/build_apk.yml'.
1. Push this folder to your GitHub repository.
2. Go to the Actions tab on GitHub.
3. The build will run automatically and provide a download link for 'student-marks-viewer-release-apk' (the APK file).
