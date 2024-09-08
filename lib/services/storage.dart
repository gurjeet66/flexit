import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> saveWorkout(String workoutName, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(workoutName, value);
  }

  static Future<double?> getWorkout(String workoutName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(workoutName);
  }

  static Future<void> removeWorkout(String workoutName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(workoutName);
  }
  Future<void> removeWorkoutDates() async {
  final prefs = await SharedPreferences.getInstance();

  // Assuming you use keys like "workout_<workout_name>_date"
  final workoutNames = ['Push-ups', 'Sit-ups', 'Squats', 'Burpees', 'Lunges', 'Plank', 'Jumping Jacks', 'Mountain Climbers', 'High Knees', 'Leg raises'];

  for (var name in workoutNames) {
    prefs.remove('workout_${name}_date');
  }
}
}
