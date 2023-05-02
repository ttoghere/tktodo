// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tktodo/bloc_folder/blocs.dart';
import 'package:tktodo/models/task.dart';
import 'package:tktodo/widgets/edit_task.dart';

import 'pop_up_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;
  void _removeOrDeleteTask(BuildContext context, Task listedTask) {
    listedTask.isDeleted!
        ? context.read<TaskBlocBloc>().add(DeleteTask(task: task))
        : context.read<TaskBlocBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: task.isDone!
                                ? FontWeight.bold
                                : FontWeight.w600,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      Text(DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.date))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TaskBlocBloc>().add(
                              UpdateTask(task: task),
                            );
                      }
                    : null,
              ),
              PopUP(
                restoreTaskCallback: () =>
                    context.read<TaskBlocBloc>().add(RestoreTask(task: task)),
                editTaskCallback: () {
                  Navigator.of(context).pop;
                  _editTask(context);
                },
                likeOrDislike: () => context
                    .read<TaskBlocBloc>()
                    .add(MarkFavoriteOrUnfavoriteTask(task: task)),
                task: task,
                cancelOrDeleteCallback: () =>
                    _removeOrDeleteTask(context, task),
              )
            ],
          )
        ],
      ),
    );
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: EditTaskScreen(
                  oldTask: task,
                ),
              ),
            ));
  }
}
