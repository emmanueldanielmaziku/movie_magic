# Movie Streaming App 🎬

A simple movie streaming app built with Flutter and Firebase, using The Movie Database (TMDb) API.

## Features

✅ Google Authentication (Firebase)  
✅ Browse popular movies from TMDb  
✅ View movie details and actors  
✅ Offline support using Hive  
✅ Responsive UI inspired by Behance

## Tech Stack

- **Flutter**
- **Firebase Authentication**
- **TMDb API**
- **Provider** (State Management)
- **Hive** (Offline Storage)
- **Dio / HTTP** (API Calls)

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


## Known Issues
- The search feature is not yet implemented.
- Some API requests may take longer due to rate limits.

## Screenshots
Screenshots will appear here , very sooon.

---

## Contributing
Feel free to fork this repository and submit pull requests. Suggestions and improvements are welcome!

## License
This project is licensed under the **MIT License**.
```
