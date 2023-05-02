part of 'task_bloc_bloc.dart';

abstract class TaskBlocEvent extends Equatable {
  const TaskBlocEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskBlocEvent {
  final Task task;
  const AddTask({required this.task});
  @override
  List<Object> get props => [task];
}

class RemoveTask extends TaskBlocEvent {
  final Task task;
  const RemoveTask({required this.task});
  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskBlocEvent {
  final Task task;
  const UpdateTask({required this.task});
  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskBlocEvent {
  final Task task;
  const DeleteTask({required this.task});
  @override
  List<Object> get props => [task];
}

class MarkFavoriteOrUnfavoriteTask extends TaskBlocEvent {
  final Task task;
  const MarkFavoriteOrUnfavoriteTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class EditTask extends TaskBlocEvent {
  final Task oldTask;
  final Task newTask;
  const EditTask({
    required this.oldTask,
    required this.newTask,
  });

  @override
  List<Object> get props => [
        oldTask,
        newTask,
      ];
}
class RestoreTask extends TaskBlocEvent {
  final Task task;
  const RestoreTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}


class DeleteAllTasks extends TaskBlocEvent {}
