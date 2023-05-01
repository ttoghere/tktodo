part of 'task_bloc_bloc.dart';

class TaskBlocState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favoriteTasks;
  final List<Task> removedTasks;
  const TaskBlocState({
   this.pendingTasks=const<Task>[],
   this.completedTasks=const<Task>[],
   this.favoriteTasks=const<Task>[],
    this.removedTasks = const <Task>[],
  });
  @override
  List<Object> get props => [pendingTasks,completedTasks,favoriteTasks, removedTasks];

  Map<String, dynamic> toMap() {
    return {
      "pendingTasks": pendingTasks.map((e) => e.toMap()).toList(),
      "favoriteTasks": favoriteTasks.map((e) => e.toMap()).toList(),
      "completedTasks": completedTasks.map((e) => e.toMap()).toList(),
      "removedTasks": removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskBlocState.fromMap(Map<String, dynamic> map) {
    return TaskBlocState(
      pendingTasks: List<Task>.from(map['pendingTasks']?.map((x) => Task.fromMap(x))),
      completedTasks: List<Task>.from(map['completedTasks']?.map((x) => Task.fromMap(x))),
      favoriteTasks: List<Task>.from(map['favoriteTasks']?.map((x) => Task.fromMap(x))),
      removedTasks:
          List<Task>.from(map['removedTasks']?.map((x) => Task.fromMap(x))),
    );
  }
}
