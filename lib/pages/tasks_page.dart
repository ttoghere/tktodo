// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tktodo/bloc_folder/blocs.dart';
import 'package:tktodo/models/task.dart';
import 'package:tktodo/services/guid_gen.dart';
import 'package:tktodo/widgets/app_drawer.dart';

class TasksPage extends StatelessWidget {
  static const String routeName = "/tasks";
  TasksPage({Key? key}) : super(key: key);

  //Bottom Sheet for Adding Tasks
  void _addTask({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _addTaskField(context),
              ),
            ),
          );
        });
  }

  //Way of adding tasks via on a textfield to storage
  Column _addTaskField(BuildContext context) {
    TextEditingController taskControl = TextEditingController();
    return Column(
      children: [
        const Text(
          "Add Task",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          autofocus: true,
          controller: taskControl,
          decoration: const InputDecoration(
              label: Text("Title"), border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                var task =
                    Task(title: taskControl.text, id: GUIDGen.generate());
                context.read<TaskBlocBloc>().add(
                      AddTask(task: task),
                    );
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBlocBloc, TaskBlocState>(
      builder: (context, state) {
        return Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: TasksList(
            tasks: state.allTasks,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addTask(context: context);
            },
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

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
