import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sm_to_do_list/common/failure.dart';
import 'package:sm_to_do_list/data/models/to_do_table.dart';

import '../../common/exception.dart';
import '../../domain/repositories/to_do_list_repository.dart';
import '../datasources/data.dart';


class ToDoListRepositoryImpl implements ToDoListRepository {
  final ToDoListDataSource localDataSource;

  ToDoListRepositoryImpl({
    required this.localDataSource,
  });


  @override
  Future<Either<Failure, List<ToDoList>>> getAllToDo() async {
    final result = await localDataSource.getAllToDo();
    return Right(result);
  }

  @override
  Future<Either<Failure, ToDoList>> getToDo(int id) async {
    try {
      final result =
      await localDataSource.getToDoById(id);
      return Right(result!);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }


  @override
  Future<Either<Failure, String>> removeToDo(ToDoList toDo) async {
    // TODO: implement removeToDo
    try {
      final result =
      await localDataSource.removeToDoList(toDo);
    return Right(result);
    } on DatabaseException catch (e) {
    return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveToDo(ToDoList toDo) async {
    try {
      final result =
      await localDataSource.insertToDoList(toDo);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> updateToDo(ToDoList toDo) async {
    try {
      final result =
      await localDataSource.updateToDoList(toDo);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}

