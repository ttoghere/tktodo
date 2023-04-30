import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tktodo/bloc_folder/blocs.dart';
import 'package:tktodo/models/task.dart';
import 'package:tktodo/services/guid_gen.dart';

class TasksPage extends StatelessWidget {
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
          appBar: AppBar(
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Tasks: ${state.allTasks.length}',
                  ),
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var task = state.allTasks[index];
                    return ListTile(
                      title: Text(task.title),
                      trailing: Checkbox(
                        value: task.isDone,
                        onChanged: (value) {
                          context.read<TaskBlocBloc>().add(
                                UpdateTask(task: task),
                              );
                        },
                      ),
                      onLongPress: () => context
                          .read<TaskBlocBloc>()
                          .add(DeleteTask(task: task)),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                        thickness: 2,
                      ),
                  itemCount: state.allTasks.length),
            ],
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
