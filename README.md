
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
