import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/pages/login_page.dart';
import 'package:tktodo/pages/recycle_bin.dart';
import 'package:tktodo/pages/tabs_page.dart';
import 'package:tktodo/repositories/auth/auth_repository.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: BlocBuilder<TaskBlocBloc, TaskBlocState>(
          builder: (context, state) {
            return Column(
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(
                    "Tasks App",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(TabsPage.routeName),
                  leading: const Icon(
                    Icons.select_all,
                  ),
                  title: Text(
                    "My Tasks",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(RecycleBin.routeName),
                  leading: const Icon(
                    Icons.delete,
                  ),
                  title: Text(
                    "Trash Bin",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  trailing: Text(
                    state.removedTasks.length.toString(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.thermostat,
                  ),
                  title: Text(
                    "Theme Mode",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  trailing: BlocBuilder<SwitchBloc, SwitchState>(
                    builder: (context, state) {
                      return Switch(
                        activeColor: Colors.white,
                        value: state.switchValue,
                        onChanged: (value) {
                          value
                              ? context.read<SwitchBloc>().add(SwitchOnEvent())
                              : context
                                  .read<SwitchBloc>()
                                  .add(SwitchOffEvent());
                        },
                      );
                    },
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    context.read<AuthRepository>().signOut().then((value) {
                      GetStorage().remove("token");
                      Navigator.of(context).pushNamed(LoginPage.routeName);
                    });
                  },
                  leading: const Icon(
                    Icons.logout_outlined,
                  ),
                  title: Text(
                    "Sign Out",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    context
                        .read<AuthRepository>()
                        .deleteAccountAndData()
                        .whenComplete(() => Navigator.of(context)
                            .pushReplacementNamed(LoginPage.routeName));
                  },
                  leading: const Icon(
                    Icons.delete_forever,
                  ),
                  title: Text(
                    "Delete Account and Saved Data",
                    style: Theme.of(context).textTheme.labelLarge,
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
