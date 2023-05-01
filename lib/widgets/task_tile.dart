// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

  ListTile _demo(BuildContext context) {
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

class PopUP extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislike;

  final Task task;
  const PopUP({
    Key? key,
    required this.likeOrDislike,
    required this.cancelOrDeleteCallback,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  onTap: () {},
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit")),
                ),
                PopupMenuItem(
                  onTap: likeOrDislike,
                  child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavorite == false
                          ? const Icon(Icons.bookmark_add_outlined)
                          : const Icon(Icons.bookmark_remove),
                      label: task.isFavorite == false
                          ? const Text("Add To Bookmarks")
                          : const Text("Remove From Bookmarks")),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete")),
                ),
              ])
          : (context) => [
                PopupMenuItem(
                  onTap: () {},
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.restore),
                      label: const Text("Restore")),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text("Delete Forever")),
                ),
              ],
    );
  }
}
