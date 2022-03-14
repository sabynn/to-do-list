import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:sm_to_do_list/data/models/to_do_table.dart';
import 'package:sqflite/sqflite.dart';

class ToDoListDatabaseHelper {
  static ToDoListDatabaseHelper? _databaseHelper;
  ToDoListDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory ToDoListDatabaseHelper() => _databaseHelper ?? ToDoListDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblToDoList = 'ToDoList';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/sm_to_do_list.db';

    var db = await openDatabase(databasePath, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblToDoList (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskName TEXT,
        taskType TEXT,
        taskStatus INTEGER,
        overallProgress TEXT,
        times TEXT,
        date TEXT
      );
    ''');
  }

  Future<int> createToDo(ToDoList toDoList) async {
    final db = await database;
    return await db!.insert(_tblToDoList, toDoList.toJson());
  }

  Future updateToDo(ToDoList toDoList) async {
    final db = await database;
    await db!.update("TodoList", toDoList.toJson(),
        where: "id = ?", whereArgs: [toDoList.id]);
    debugPrint("${toDoList.toJson()}");
  }

  Future<int> removeToDo(int id) async {
    final db = await database;
    return await db!.delete(
      _tblToDoList,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> getToDoById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblToDoList,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllToDo() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblToDoList);

    return results;
  }
}
