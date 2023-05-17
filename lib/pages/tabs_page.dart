import 'package:flutter/material.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/models/task.dart';
import 'package:tktodo/pages/pages.dart';
import 'package:tktodo/services/services.dart';
import 'package:tktodo/widgets/widgets.dart';

class TabsPage extends StatefulWidget {
  static const routeName = "/tabs";
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<Map<String, dynamic>> _pageDetails = [
    {"pageName": const PendingPage(), "title": "Pending Tasks"},
    {"pageName": const CompletedPage(), "title": "Completed Tasks"},
    {"pageName": const FavoritePage(), "title": "Favorite Tasks"},
  ];

  int _selectedIndex = 0;
  @override
  void initState() {
    context.read<TaskBlocBloc>().add(GetAllTasks());
    super.initState();
  }

  //Bottom Sheet for Adding Tasks
  void _addTask({required BuildContext context}) {
    showModalBottomSheet(
        isScrollControlled: true,
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
    TextEditingController descriptionControl = TextEditingController();
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
          height: 10,
        ),
        TextField(
          minLines: 3,
          maxLines: 5,
          controller: descriptionControl,
          decoration: const InputDecoration(
              label: Text("Description"), border: OutlineInputBorder()),
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
                var task = Task(
                  date: DateTime.now().toString(),
                  title: taskControl.text,
                  id: GUIDGen.generate(),
                  description: descriptionControl.text,
                );
                context.read<TaskBlocBloc>().add(
                      AddTask(task: task),
                    );
                context.read<TaskBlocBloc>().add(GetAllTasks());
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
    var mapAccess = _pageDetails[_selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(mapAccess["title"]),
        actions: [
          IconButton(
            onPressed: () => _addTask(context: context),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: mapAccess["pageName"],
      drawer: const AppDrawer(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _addTask(context: context);
              },
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp),
              label: "Pending Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: "Completed Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite Tasks"),
        ],
      ),
    );
  }
}
