part of 'task_bloc_bloc.dart';

class TaskBlocState extends Equatable {
  final List<Task> allTasks;
  const TaskBlocState({
    this.allTasks = const <Task>[],
  });
  @override
  List<Object> get props => [allTasks];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allTasks': allTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskBlocState.fromMap(Map<String, dynamic> map) {
    return TaskBlocState(
      allTasks: List<Task>.from(
        (map['allTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
