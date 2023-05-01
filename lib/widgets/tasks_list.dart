import 'package:flutter/material.dart';
import 'package:tktodo/models/task.dart';
import 'package:tktodo/widgets/widgets.dart';


class TasksList extends StatelessWidget {
  final List<Task> tasks;
  const TasksList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Chip(
            label: Text(
              'Tasks: ${tasks.length}',
            ),
          ),
        ),
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var task = tasks[index];
              return TaskTile(task: task);
            },
            separatorBuilder: (context, index) => const Divider(
                  thickness: 2,
                ),
            itemCount: tasks.length),
      ],
    );
  }
}