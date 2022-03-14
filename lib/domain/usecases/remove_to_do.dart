import 'package:dartz/dartz.dart';
import 'package:sm_to_do_list/data/models/to_do_table.dart';
import 'package:sm_to_do_list/domain/repositories/to_do_list_repository.dart';
import '../../common/failure.dart';

class RemoveToDo {
  final ToDoListRepository repository;

  RemoveToDo(this.repository);

  Future<Either<Failure, String>> execute(ToDoList toDo) {
    return repository.removeToDo(toDo);
  }
}
