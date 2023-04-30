import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tktodo/bloc_folder/blocs.dart';
import 'package:tktodo/pages/recycle_bin.dart';
import 'package:tktodo/pages/tasks_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.red,
        child: BlocBuilder<TaskBlocBloc, TaskBlocState>(
          builder: (context, state) {
            return Column(
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(
                    "Tasks App",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () =>
                      Navigator.of(context).pushNamed(TasksPage.routeName),
                  leading: const Icon(
                    Icons.list_alt_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "My Tasks",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                  ),
                  trailing: Text(
                    state.allTasks.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.white54,
                ),
                ListTile(
                  onTap: () =>
                      Navigator.of(context).pushNamed(RecycleBin.routeName),
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Trash Bin",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                  ),
                  trailing: Text(
                    state.removedTasks.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
