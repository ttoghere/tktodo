import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tktodo/models/task.dart';
import 'package:tktodo/repositories/tasks/base_task_repository.dart';

class TaskRepository extends BaseTaskRepository {
  final FirebaseFirestore _firebaseFirestore;
  TaskRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addTask({Task? task}) async {
    try {
      await _firebaseFirestore
          .collection(GetStorage().read("email"))
          .doc(task!.id)
          .set(task.toMap());
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    List<Task> tasksList = [];
    try {
      final data =
          await _firebaseFirestore.collection(GetStorage().read("email")).get();
      for (var task in data.docs) {
        tasksList.add(Task.fromMap(task.data()));
      }
      return tasksList;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateTask({Task? task}) async {
    try {
      final data = _firebaseFirestore.collection(GetStorage().read("email"));
      data.doc(task!.id).update(task.toMap());
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  @override
  Future<void> deleteTask({Task? task}) async {
    try {
      final data = _firebaseFirestore.collection(GetStorage().read("email"));
      data.doc(task!.id).delete();
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  @override
  Future<void> deleteAllRemovedTasks({List<Task>? taskList}) async {
    try {
      final data = _firebaseFirestore.collection(GetStorage().read("email"));
      for (var task in taskList!) {
        data.doc(task.id).delete();
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
