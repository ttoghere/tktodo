// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tktodo/bloc_folder/blocs.dart';
import 'package:tktodo/widgets/widgets.dart';

class CompletedPage extends StatelessWidget {
  static const String routeName = "/completed";
  const CompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBlocBloc, TaskBlocState>(
      builder: (context, state) {
        return Scaffold(
          body: TasksList(
            tasks: state.completedTasks,
          ),
        );
      },
    );
  }
}
