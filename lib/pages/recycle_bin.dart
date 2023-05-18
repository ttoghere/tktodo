import 'package:flutter/material.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/widgets/widgets.dart';

class RecycleBin extends StatefulWidget {
  static const String routeName = "/bin";

  const RecycleBin({super.key});

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Recycle Bin'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<TaskBlocBloc>().add(DeleteAllTasks());
                context.read<TaskBlocBloc>().add(GetAllTasks());
              },
              icon: const Icon(Icons.delete_forever),
            )
          ],
        ),
        body: BlocBuilder<TaskBlocBloc, TaskBlocState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TasksList(tasks: state.removedTasks),
                ],
              ),
            );
          },
        ));
  }
}
