import 'package:flutter/material.dart';
import 'package:sm_to_do_list/common/styles.dart';
import 'package:sm_to_do_list/presentation/bloc/to_do_list_bloc.dart';

import '../../data/models/to_do_table.dart';

class ToDoListCard extends StatelessWidget {
  final ToDoList toDoListTable;
  final ToDoListBloc toDoListBloc;
  bool bookmarked;
  bool finished;

  ToDoListCard(
    this.toDoListTable,
    this.toDoListBloc, {
    this.bookmarked = false,
    this.finished = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  toDoListTable.taskName ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kHeading6,
                ),
                SizedBox(height: 1),
                Row(
                  children: [
                    Icon(
                      Icons.book_rounded,
                      size: 18,
                    ),
                    Text(
                      toDoListTable.taskType ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 18,
                    ),
                    Text(
                      toDoListTable.date ?? '-',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.av_timer,
                      size: 18,
                    ),
                    Text(
                      toDoListTable.times ?? '-',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            bookmarked
                ? IconButton(
                    onPressed: () {
                      toDoListTable.taskStatus = 0;
                      toDoListBloc.add(
                        EventUpdateToDoList(toDoListTable: toDoListTable),
                      );
                    },
                    icon: Icon(
                      Icons.bookmark_added,
                      color: kPrimaryColor,
                    ),
                  )
                : Container(),
            finished || bookmarked ? Container() : IconButton(
              onPressed: () {
                toDoListTable.taskStatus = 1;
                toDoListBloc.add(
                  EventUpdateToDoList(toDoListTable: toDoListTable),
                );
              },
              icon: Icon(
                Icons.bookmark_add_outlined,
                color: kPrimaryColor,
              ),
            ),
            !finished ? IconButton(
              onPressed: () {
                toDoListTable.taskStatus = 2;
                toDoListBloc.add(
                  EventUpdateToDoList(toDoListTable: toDoListTable),
                );
              },
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ) : Container(),
            IconButton(
              onPressed: () {
                toDoListBloc.add(
                  EventRemoveToDoList(toDoListTable: toDoListTable),
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
