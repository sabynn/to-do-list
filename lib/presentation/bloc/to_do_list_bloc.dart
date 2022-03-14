import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sm_to_do_list/data/models/to_do_table.dart';
import 'package:sm_to_do_list/domain/usecases/get_to_do_list.dart';
import 'package:sm_to_do_list/domain/usecases/remove_to_do.dart';
import 'package:sm_to_do_list/domain/usecases/save_to_do.dart';

import '../../domain/usecases/update_to_do.dart';

part 'to_do_list_event.dart';
part 'to_do_list_state.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  final GetToDoList _getToDoList;
  List<ToDoList> _toDoList = [];
  late ToDoList _toDo;
  final SaveToDo _saveToDo;
  final RemoveToDo _deleteToDo;
  final UpdateToDo _updateToDo;

  List<ToDoList> get toDoList => _toDoList;
  ToDoList get toDo => _toDo;

  String _message = '';
  String get message => _message;

  ToDoListBloc({
    required GetToDoList getToDoList,
    required SaveToDo saveToDo,
    required RemoveToDo deleteToDo,
    required UpdateToDo updateToDo,
  })  : _getToDoList = getToDoList,
        _saveToDo = saveToDo,
        _deleteToDo = deleteToDo,
        _updateToDo = updateToDo,
        super(ToDoListStateInitial()) {
    on<EventLoadToDoList>(_loadToDoList);
    on<EventAddToDoList>(_addToDo);
    on<EventRemoveToDoList>(_removeToDo);
    on<EventUpdateToDoList>(_reNewToDo);
  }

  void _loadToDoList(
    EventLoadToDoList event,
    Emitter<ToDoListState> emit,
  ) async {
    emit(ToDoListStateInitial());
    final result = await _getToDoList.execute();
    result.fold(
      (failure) {
        _message = message;
        emit(
          ToDoListStateFailure(
            message: failure.message,
          ),
        );
      },
      (data) {
        _toDoList = data;
        emit(ToDoListStateLoaded());
      },
    );
  }

  void _addToDo(
    EventAddToDoList event,
    Emitter<ToDoListState> emit,
  ) async {
    emit(ToDoListStateLoading());
    final result = await _saveToDo.execute(event.toDoListTable);
    await result.fold(
      (failure) async {
        emit(ToDoListStateFailure(message: failure.message));
      },
      (successMessage) async {
        emit(ToDoListStateSuccess(successMessage));
      },
    );
  }

  void _removeToDo(
    EventRemoveToDoList event,
    Emitter<ToDoListState> emit,
  ) async {
    emit(ToDoListStateLoading());
    final result = await _deleteToDo.execute(event.toDoListTable);

    await result.fold(
      (failure) async {
        emit(ToDoListStateFailure(message: failure.message));
      },
      (successMessage) async {
        emit(ToDoListStateSuccess(successMessage));
      },
    );
  }

  void _reNewToDo(
      EventUpdateToDoList event,
      Emitter<ToDoListState> emit,
      ) async {
    emit(ToDoListStateLoading());
    final result = await _updateToDo.execute(event.toDoListTable);

    await result.fold(
          (failure) async {
        emit(ToDoListStateFailure(message: failure.message));
      },
          (successMessage) async {
        emit(ToDoListStateSuccess(successMessage));
      },
    );
  }
}
