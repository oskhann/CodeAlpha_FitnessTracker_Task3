import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/workout.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('workouts.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        sets INTEGER,
        reps INTEGER,
        duration INTEGER,
        date TEXT
      )
    ''');
  }

  Future<int> addWorkout(Workout workout) async {
    final db = await database;
    return await db.insert('workouts', workout.toMap());
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('workouts', orderBy: 'date DESC');
    return maps.map((e) => Workout.fromMap(e)).toList();
  }

  Future<int> deleteWorkout(int id) async {
    final db = await database;
    return await db.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }
}
