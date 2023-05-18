import 'package:tktodo/models/task.dart';

abstract class BaseTaskRepository {
  Future<void> addTask({Task? task});
  Future<List<Task>> getTasks();
  Future<void> updateTask({Task? task});
  Future<void> deleteTask({Task? task});
  Future<void> deleteAllRemovedTasks({List<Task>? taskList});
}
