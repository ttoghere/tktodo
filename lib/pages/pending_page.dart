// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/widgets/widgets.dart';


class PendingPage extends StatelessWidget {
  static const String routeName = "/pending";
  const PendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBlocBloc, TaskBlocState>(
      builder: (context, state) {
        return Scaffold(
          body: TasksList(
            tasks: state.pendingTasks,
          ),
        );
      },
    );
  }
}

