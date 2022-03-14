import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../data/models/to_do_table.dart';


abstract class ToDoListRepository {
  Future<Either<Failure, ToDoList>> getToDo(int id);
  Future<Either<Failure, List<ToDoList>>> getAllToDo();
  Future<Either<Failure, String>> saveToDo(ToDoList toDo);
  Future<Either<Failure, String>> removeToDo(ToDoList toDo);
  Future<Either<Failure, String>> updateToDo(ToDoList toDo);
}
