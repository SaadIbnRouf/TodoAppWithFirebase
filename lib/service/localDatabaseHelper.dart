import '../model/todoDataModel.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataBaseHelper {
  static const int _version = 1;
  static const String _dbName = 'task_db.db';

  // create a local database if not already created

  static Future<Database> getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Todos(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL)');
      },
      version: _version,
    );
  }

  // Add data

  static Future<void> addTask(TodoDataModel note) async {
    final db = await getDB();
    db.insert('Todos', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // read data

  static Future<List<TodoDataModel>?> getAllTask() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('Todos');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => TodoDataModel.fromJson(maps[index]));
  }

  // Update data

  static Future<void> updateTask(TodoDataModel todoDataModel) async {
    final db = await getDB();
    await db.update('Todos', todoDataModel.toMap(),
        where: 'id = ?', whereArgs: [todoDataModel.id]);
  }

  // Delete data

  static Future<void> deleteTask(TodoDataModel todoDataModel) async {
    final db = await getDB();
    await db.delete('Todos', where: 'id = ?', whereArgs: [todoDataModel.id]);
  }
}
