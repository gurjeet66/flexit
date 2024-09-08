import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _availableWorkouts = [];
  
  List<Workout> get availableWorkouts => _availableWorkouts;

  WorkoutProvider() {
    _loadWorkouts();
  }

  // Load workouts from SharedPreferences
  Future<void> _loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final workoutsJson = prefs.getString('workouts');
    if (workoutsJson != null) {
      final List<dynamic> decodedJson = jsonDecode(workoutsJson);
      _availableWorkouts = decodedJson.map((item) => Workout.fromJson(item)).toList();
    }
    notifyListeners();
  }

  // Save workouts to SharedPreferences
  Future<void> _saveWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final workoutsJson = jsonEncode(_availableWorkouts.map((w) => w.toJson()).toList());
    await prefs.setString('workouts', workoutsJson);
  }

  // Add default workouts
  void addDefaultWorkouts() {
    _availableWorkouts = [
      Workout(id: '1', name: 'Push-ups', imagePath: 'assets/pushup.png', date: DateTime.now(), isCompletedToday: false),
      Workout(id: '2', name: 'Sit-ups', imagePath: 'assets/—Pngtree—sit-ups athletic girl_4599740.png', date: DateTime.now(), isCompletedToday: false),
      Workout(id: '3', name: 'Squats', imagePath: 'assets/squats.png', date: DateTime.now(), isCompletedToday: false),
      Workout(id: '4', name: 'planks', imagePath: 'assets/plank.png', date: DateTime.now(), isCompletedToday: false),
      Workout(id: '5', name: 'leg raises', imagePath: 'assets/leg raise.png', date: DateTime.now(), isCompletedToday: false),
      Workout(id: '6', name: 'jumping jacks', imagePath: 'assets/Jumping jacks.png', date: DateTime.now(), isCompletedToday: false),
      Workout(id: '7', name: 'lunges', imagePath: 'assets/lunges.png', date: DateTime.now(), isCompletedToday: false),
      Workout(id: '8', name: 'Burpees', imagePath: 'assets/Burpees.png', date: DateTime.now(), isCompletedToday: false),
      // Add other workouts as needed
    ];
    _saveWorkouts();
    notifyListeners();
  }

  // Update a workout
  void updateWorkout(Workout updatedWorkout) {
    final index = _availableWorkouts.indexWhere((w) => w.id == updatedWorkout.id);
    if (index != -1) {
      _availableWorkouts[index] = updatedWorkout;
      _saveWorkouts();
      notifyListeners();
    }
  }

  // Filter workouts by completion status
  List<Workout> getFilteredWorkouts({required bool isCompleted}) {
    return _availableWorkouts.where((workout) => workout.isCompletedToday == isCompleted).toList();
  }

  // Filter workouts by date and completion status
  List<Workout> getFilteredWorkoutsByDateAndStatus(DateTime? filterDate, {required bool isCompleted}) {
    return _availableWorkouts.where((workout) {
      bool dateMatch = filterDate == null ||
          (workout.date.year == filterDate.year &&
           workout.date.month == filterDate.month &&
           workout.date.day == filterDate.day);
      return dateMatch && workout.isCompletedToday == isCompleted;
    }).toList();
  }
}
