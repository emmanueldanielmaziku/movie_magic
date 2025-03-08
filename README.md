# Movie Streaming App 🎬

A simple movie streaming app built with Flutter and Firebase, using The Movie Database (TMDb) API.

---

## Features

✅ **Google Authentication (Firebase)**  
✅ **Browse popular movies from TMDb**  
✅ **View movie details and actors**  
✅ **Offline support using Hive**  
✅ **Responsive UI inspired by Behance**

---

## Tech Stack

- **Flutter**  
- **Firebase Authentication**  
- **TMDb API**  
- **Get** (State Management)  
- **Hive** (Offline Storage)  
- **Dio / HTTP** (API Calls)  

---

## External Libraries and Packages

Here’s a list of the external libraries and packages used in this project, along with their purposes:

### Dependencies

1. **flutter**:  
   - **Version**: SDK  
   - **Description**: The core framework for building Flutter applications.  
   - **Usage**: Provides the necessary tools and widgets to build the UI and manage app state.

2. **cupertino_icons**:  
   - **Version**: ^1.0.8  
   - **Description**: Provides Cupertino-style icons for iOS-themed applications.  
   - **Usage**: Used for displaying iOS-style icons in the app.

3. **shimmer**:  
   - **Version**: ^3.0.0  
   - **Description**: A package that provides a shimmer effect for loading placeholders.  
   - **Usage**: Used to display shimmering placeholders while content is being loaded.

4. **flutter_svg**:  
   - **Version**: ^2.0.17  
   - **Description**: A library to render SVG files in Flutter.  
   - **Usage**: Used to display scalable vector graphics in the app.

5. **google_sign_in**:  
   - **Version**: ^6.2.2  
   - **Description**: A plugin for integrating Google Sign-In functionality.  
   - **Usage**: Used for authenticating users via their Google accounts.

6. **firebase_core**:  
   - **Version**: ^3.12.1  
   - **Description**: The core Firebase plugin required for using Firebase services.  
   - **Usage**: Initializes Firebase services in the app.

7. **firebase_auth**:  
   - **Version**: ^5.5.1  
   - **Description**: A plugin for Firebase Authentication.  
   - **Usage**: Used for user authentication and managing user sessions.

8. **dio**:  
   - **Version**: ^5.8.0+1  
   - **Description**: A powerful HTTP client for Dart.  
   - **Usage**: Used for making HTTP requests to APIs.

9. **iconsax**:  
   - **Version**: ^0.0.8  
   - **Description**: A collection of modern icons.  
   - **Usage**: Used for displaying icons in the app.

10. **carousel_slider**:  
    - **Version**: ^5.0.0  
    - **Description**: A carousel slider widget for Flutter.  
    - **Usage**: Used to display a carousel of images or widgets.

11. **smooth_page_indicator**:  
    - **Version**: ^1.2.1  
    - **Description**: A package for creating smooth page indicators.  
    - **Usage**: Used to indicate the current page in a carousel or page view.

12. **get**:  
    - **Version**: ^4.7.2  
    - **Description**: A lightweight and powerful state management solution.  
    - **Usage**: Used for managing app state and navigation.

13. **hive**:  
    - **Version**: ^2.2.3  
    - **Description**: A lightweight and fast NoSQL database for Flutter.  
    - **Usage**: Used for local data storage.

14. **hive_flutter**:  
    - **Version**: ^1.1.0  
    - **Description**: Flutter integration for Hive.  
    - **Usage**: Used to initialize Hive in a Flutter app.

15. **connectivity_plus**:  
    - **Version**: ^6.1.3  
    - **Description**: A plugin for checking network connectivity.  
    - **Usage**: Used to monitor the app's network connection status.

16. **cached_network_image**:  
    - **Version**: ^3.4.1  
    - **Description**: A library for loading and caching network images.  
    - **Usage**: Used to display images from the internet with caching.

---

### Dev Dependencies

1. **flutter_test**:  
   - **Version**: SDK  
   - **Description**: The Flutter testing framework.  
   - **Usage**: Used for writing unit and widget tests.

2. **flutter_lints**:  
   - **Version**: ^4.0.0  
   - **Description**: A set of recommended lints for Flutter projects.  
   - **Usage**: Used to enforce good coding practices.

3. **hive_generator**:  
   - **Version**: ^2.0.1  
   - **Description**: A code generator for Hive.  
   - **Usage**: Used to generate TypeAdapters for Hive.

4. **build_runner**:  
   - **Version**: ^2.4.13  
   - **Description**: A tool for running code generators.  
   - **Usage**: Used to generate code for Hive and other libraries.

5. **flutter_launcher_icons**:  
   - **Version**: ^0.14.3  
   - **Description**: A package for generating launcher icons.  
   - **Usage**: Used to generate app icons for Android and iOS.

---

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/emmanueldanielmaziku/movie_magic.git
cd movie_magic
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Set Up Firebase

- Create a **Firebase project** in the [Firebase Console](https://console.firebase.google.com/).
- Enable **Google Authentication**.
- Download and add the **google-services.json** (Android) and **GoogleService-Info.plist** (iOS) to your project.

### 4. Get TMDb API Key

- Sign up at [TMDb](https://www.themoviedb.org/) and get an **API key**.
- Add your API key to the app (inside an environment file or API service class).

### 5. Run the App

```bash
flutter run
```

---

## Project Structure

```
📂 movie-magic/
 ┣ 📂 lib/
 ┃ ┣ 📂 screens/   # UI Screens (Home, Movie Details, Actor Details, etc.)
 ┃ ┣ 📂 services/  # API Calls and Firebase Auth
 ┃ ┣ 📂 models/    # Data Models (Movie, Actor, etc.)
 ┃ ┣ 📂 providers/ # State Management (Provider)
 ┃ ┗ 📜 main.dart  # Entry Point
 ┣ 📂 assets/      # Images, icons, etc.
 ┣ 📜 pubspec.yaml # Dependencies
 ┗ 📜 README.md
```

---

## Known Issues

### 1. **Dependency Issues**
   - **Issue**: Errors like `Could not resolve dependencies` or `Version solving failed` when running `flutter pub get`.
   - **Solution**:
     - Ensure your Flutter SDK is up to date by running:
       ```bash
       flutter upgrade
       ```
     - Delete the `pubspec.lock` file and run:
       ```bash
       flutter pub get
       ```
     - If the issue persists, check the versions of the dependencies in `pubspec.yaml` and ensure they are compatible with your Flutter SDK version.

---

### 2. **Firebase Configuration Errors**
   - **Issue**: Errors like `FirebaseApp not initialized` or `Missing GoogleService-Info.plist` when running the app.
   - **Solution**:
     - Ensure you have set up Firebase correctly for both Android and iOS:
       - Follow the [Firebase setup guide](https://firebase.flutter.dev/docs/overview) for Flutter.
       - Download the `google-services.json` file for Android and the `GoogleService-Info.plist` file for iOS from the Firebase Console.
       - Place these files in the correct directories:
         - Android: `android/app/google-services.json`
         - iOS: `ios/Runner/GoogleService-Info.plist`
     - Rebuild the app after adding the configuration files.

---

### 3. **Hive Initialization Errors**
   - **Issue**: Errors like `Hive not initialized` or `TypeAdapter not found`.
   - **Solution**:
     - Ensure you have initialized Hive in your app:
       ```dart
       await Hive.initFlutter();
       ```
     - If using Hive with TypeAdapters, ensure you have run the code generator:
       ```bash
       flutter pub run build_runner build
       ```
     - Register your adapters before using them:
       ```dart
       Hive.registerAdapter(YourAdapter());
       ```

---

## Contributing

Feel free to fork this repository and submit pull requests. Suggestions and improvements are welcome!

---

## License

This project is licensed under the **MIT License**.
