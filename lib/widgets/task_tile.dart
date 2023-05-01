import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tktodo/bloc_folder/blocs.dart';
import 'package:tktodo/models/task.dart';

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
    return ListTile(
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: task.isDone! ? FontWeight.bold : FontWeight.w600,
            decoration: task.isDone!
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      trailing: !task.isDeleted!
          ? Checkbox(
              value: task.isDone,
              onChanged: (value) {
                context.read<TaskBlocBloc>().add(
                      UpdateTask(task: task),
                    );
              },
            )
          : null,
      onLongPress: () => _removeOrDeleteTask(context, task),
    );
  }
}
