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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: Text(
                'Tasks: ${tasks.length}',
              ),
            ),
          ),
          SingleChildScrollView(
            child: ExpansionPanelList.radio(
              children: tasks
                  .map(
                    (e) => ExpansionPanelRadio(
                      value: e.id,
                      headerBuilder: (context, isOpen) => TaskTile(task: e),
                      body: ListTile(
                        title: SelectableText.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Text:\n",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: "${e.title}\n"),
                              const TextSpan(
                                text: "\nDescription:\n",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: e.description),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
