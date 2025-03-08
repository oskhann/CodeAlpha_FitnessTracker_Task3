import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../services/services/database_helper.dart';

class WorkoutProvider extends ChangeNotifier {
  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  Future<void> loadWorkouts() async {
    _workouts = await DatabaseHelper.instance.getWorkouts();
    notifyListeners();
  }

  Future<void> addWorkout(Workout workout) async {
    await DatabaseHelper.instance.addWorkout(workout);
    await loadWorkouts();
  }

  Future<void> deleteWorkout(int id) async {
    await DatabaseHelper.instance.deleteWorkout(id);
    await loadWorkouts();
  }
}
