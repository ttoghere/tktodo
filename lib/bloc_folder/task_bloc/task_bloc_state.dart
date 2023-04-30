part of 'task_bloc_bloc.dart';

class TaskBlocState extends Equatable {
  final List<Task> allTasks;
  final List<Task> removedTasks;
  const TaskBlocState({
    this.allTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });
  @override
  List<Object> get props => [allTasks, removedTasks];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allTasks': allTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskBlocState.fromMap(Map<String, dynamic> map) {
    return TaskBlocState(
      allTasks: List<Task>.from(
        (map['allTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      removedTasks: List<Task>.from(
        (map['removedTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
