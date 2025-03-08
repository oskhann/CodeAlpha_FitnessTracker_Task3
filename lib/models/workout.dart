class Workout {
  int? id;
  String name;
  int sets;
  int reps;
  int duration; // in minutes
  DateTime date;

  Workout({
    this.id,
    required this.name,
    required this.sets,
    required this.reps,
    required this.duration,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sets': sets,
      'reps': reps,
      'duration': duration,
      'date': date.toIso8601String(),
    };
  }

  static Workout fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      name: map['name'],
      sets: map['sets'],
      reps: map['reps'],
      duration: map['duration'],
      date: DateTime.parse(map['date']),
    );
  }
}
