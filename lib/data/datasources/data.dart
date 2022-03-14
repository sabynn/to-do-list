import 'package:sm_to_do_list/common/exception.dart';
import 'package:sm_to_do_list/data/models/to_do_table.dart';

import 'db/database_helper.dart';

abstract class ToDoListDataSource {
  Future<String> insertToDoList(ToDoList toDoListTable);
  Future<String> removeToDoList(ToDoList toDoListTable);
  Future<ToDoList?> getToDoById(int id);
  Future<List<ToDoList>> getAllToDo();
  Future<String> updateToDoList(ToDoList toDoListTable);
}

class ToDoListDataSourceImpl implements ToDoListDataSource {
  final ToDoListDatabaseHelper databaseHelper;

  ToDoListDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertToDoList(ToDoList toDoList) async {
    try {
      await databaseHelper.createToDo(toDoList);
      return 'Added to To Do List';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeToDoList(ToDoList toDoList) async {
    try {
      await databaseHelper.removeToDo(toDoList.id);
      return 'Removed from to do';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> updateToDoList(ToDoList toDoList) async {
    try {
      await databaseHelper.updateToDo(toDoList);
      return 'Update to do';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<ToDoList?> getToDoById(int id) async {
    final result = await databaseHelper.getToDoById(id);
    if (result != null) {
      return ToDoList.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<ToDoList>> getAllToDo() async {
    final result = await databaseHelper.getAllToDo();
    return result.map((data) => ToDoList.fromMap(data)).toList();
  }
}