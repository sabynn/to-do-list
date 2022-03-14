import 'package:equatable/equatable.dart';

class ToDoList extends Equatable {
  int id;
  String? taskName;
  String? taskType;
  int? taskStatus;
  String? overallProgress;
  String? date;
  String? times;

  ToDoList(
    this.id,
    this.taskName,
    this.taskType,
    this.taskStatus,
    this.overallProgress,
    this.date,
    this.times,
  );

  factory ToDoList.fromMap(Map<String, dynamic> map) => ToDoList(
        map['id'],
        map['taskName'],
        map['taskType'],
        map['taskStatus'],
        map['overallProgress'],
        map['date'],
        map['times'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'taskName': taskName,
        'taskType': taskType,
        'taskStatus': taskStatus,
        'overallProgress': overallProgress,
        'times': times,
        'date': date,
      };

  @override
  List<Object?> get props => [
        id,
        taskName,
        taskType,
        taskStatus,
        overallProgress,
        date,
        times,
      ];
}
