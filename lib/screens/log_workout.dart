import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/workout.dart';
import '../providers/workout_provider.dart';

class LogWorkoutScreen extends StatefulWidget {
  @override
  _LogWorkoutScreenState createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int sets = 0, reps = 0, duration = 0;

  void _submitWorkout() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newWorkout = Workout(
        name: name,
        sets: sets,
        reps: reps,
        duration: duration,
        date: DateTime.now(),
      );
      Provider.of<WorkoutProvider>(context, listen: false).addWorkout(newWorkout);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log Workout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Workout Name"),
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Sets"),
                keyboardType: TextInputType.number,
                onSaved: (value) => sets = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Reps"),
                keyboardType: TextInputType.number,
                onSaved: (value) => reps = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Duration (minutes)"),
                keyboardType: TextInputType.number,
                onSaved: (value) => duration = int.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submitWorkout, child: Text("Save Workout"))
            ],
          ),
        ),
      ),
    );
  }
}
