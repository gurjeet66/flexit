Workout Tracker App
This is a Flutter-based workout tracker app that allows users to keep track of their daily workouts. The app stores workout data, including completion status and custom values, in local storage using SharedPreferences, ensuring that the data persists across app restarts.

Features
Workout Management: Add, update, and manage a list of workouts.
Daily Tracking: Track the completion status of workouts on a daily basis.
Persistent Storage: Workout data is saved locally and persists even after the app is restarted.
Filter Workouts: Filter workouts based on date and completion status.
Getting Started--
Prerequisites
Flutter SDK
Dart SDK
A code editor (e.g., Visual Studio Code, Android Studio)
An emulator or a physical device for testing
Installation
Clone the Repository
git clone https://github.com/your-username/workout-tracker.git
cd workout-tracker
Install Dependencies
Run the following command to install the required dependencies:
flutter pub get
Run the App
Launch the app on your connected device or emulator:
flutter run
Project Structure
lib/
├── models/
│   └── workout.dart          # Workout model class
├── providers/
│   └── workout_provider.dart # WorkoutProvider class for state management
├── storage/
│   └── storage.dart          # Storage class for managing SharedPreferences
├── screens/
│   ├── home_screen.dart      # Main home screen
│   └── chart_page.dart       # Chart page for workout statistics
└── main.dart                 # Entry point of the application
Workout Model
This class represents a workout with the following fields:
id: Unique identifier for the workout.
name: Name of the workout.
imagePath: Path to the workout image.
date: The date the workout was completed.
isCompletedToday: Boolean indicating if the workout is completed for the day.
value: An optional value associated with the workout (e.g., reps, duration).
WorkoutProvider
The WorkoutProvider class manages the state of workouts. It handles loading, saving, and updating workout data using the Storage class.

Storage
The Storage class is responsible for interacting with SharedPreferences to save and retrieve workout data. This ensures that data persists across app restarts.

