part of 'to_do_list_bloc.dart';

abstract class ToDoListState extends Equatable {
  const ToDoListState();

  @override
  List<Object> get props => [];
}

class ToDoListStateInitial extends ToDoListState {}

class ToDoListStateLoading extends ToDoListState {}

class ToDoListStateLoaded extends ToDoListState {}

class ToDoListStateFailure extends ToDoListState {
  final String message;

  ToDoListStateFailure({
    this.message = "",
  });
}

class ToDoListStateSuccess extends ToDoListState {
  final String message;

  const ToDoListStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}