part of 'to_do_list_bloc.dart';

abstract class ToDoListEvent {}

class EventLoadToDoList extends ToDoListEvent {}

class EventUpdateToDoList extends ToDoListEvent {
  final ToDoList toDoListTable;

  EventUpdateToDoList({
    required this.toDoListTable,
  });

  List<Object?> get props => [toDoListTable];
}

class EventAddToDoList extends ToDoListEvent {
  final ToDoList toDoListTable;

  EventAddToDoList({
    required this.toDoListTable,
  });

  List<Object?> get props => [toDoListTable];
}

class EventRemoveToDoList extends ToDoListEvent {
  final ToDoList toDoListTable;

  EventRemoveToDoList({
    required this.toDoListTable,
  });

  List<Object?> get props => [toDoListTable];
}