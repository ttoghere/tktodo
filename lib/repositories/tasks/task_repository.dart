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
}
