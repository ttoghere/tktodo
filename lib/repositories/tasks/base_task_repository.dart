import 'package:tktodo/models/task.dart';

abstract class BaseTaskRepository {
  Future<void> addTask({Task? task});
  Future<List<Task>> getTasks();
}
