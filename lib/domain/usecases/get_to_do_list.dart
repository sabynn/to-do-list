import 'package:dartz/dartz.dart';
import 'package:sm_to_do_list/domain/repositories/to_do_list_repository.dart';

import '../../common/failure.dart';
import '../../data/models/to_do_table.dart';
import '../../data/repositories/to_do_list_repository_impl.dart';

class GetToDoList {
  final ToDoListRepository _repository;

  GetToDoList(this._repository);

  Future<Either<Failure, List<ToDoList>>> execute() {
    return _repository.getAllToDo();
  }
}