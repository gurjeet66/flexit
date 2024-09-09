# Workout Tracker App

The Workout Tracker App is a Flutter-based application designed to help users keep track of their daily workouts. The app saves workout data, including completion status and custom values, in local storage using SharedPreferences, ensuring that the data persists across app restarts.

## Features

- **Workout Management**: Add, update, and manage a list of workouts.
- **Daily Tracking**: Track the completion status of workouts on a daily basis.
- **Persistent Storage**: Workout data is saved locally and persists even after the app is restarted.
- **Filter Workouts**: Filter workouts based on date and completion status.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)
- A code editor (e.g., Visual Studio Code, Android Studio)
- An emulator or a physical device for testing

### Installation
#### Clone the Repository
git clone https://github.com/your-username/workout-tracker.git
cd workout-tracker
### Run code
- flutter pub get
- flutter run

id: Unique identifier for the workout.
name: Name of the workout.
imagePath: Path to the workout image.
date: The date the workout was completed.
isCompletedToday: Boolean indicating if the workout is completed for the day.
value: An optional value associated with the workout (e.g., reps, duration).
