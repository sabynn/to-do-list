import 'package:dartz/dartz.dart';
import 'package:sm_to_do_list/domain/repositories/to_do_list_repository.dart';

import '../../common/failure.dart';
import '../../data/models/to_do_table.dart';


class UpdateToDo {
  final ToDoListRepository repository;

  UpdateToDo(this.repository);

  Future<Either<Failure, String>> execute(ToDoList toDo) {
    return repository.updateToDo(toDo);
  }
}