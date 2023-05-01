import 'package:equatable/equatable.dart';
import 'package:tktodo/bloc_folder/blocs.dart';
import 'package:tktodo/models/task.dart';

part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TaskBlocBloc extends HydratedBloc<TaskBlocEvent, TaskBlocState> {
  TaskBlocBloc() : super(const TaskBlocState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }
  void _onAddTask(AddTask event, Emitter<TaskBlocState> emit) {
    final state = this.state;
    emit(
      TaskBlocState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        removedTasks: state.removedTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskBlocState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false))
          };
    emit(TaskBlocState(
      pendingTasks: pendingTasks,
      removedTasks: state.removedTasks,
      favoriteTasks: state.favoriteTasks,
      completedTasks: completedTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskBlocState> emit) {
    final state = this.state;
    emit(
      TaskBlocState(
          pendingTasks: state.pendingTasks,
          favoriteTasks: state.favoriteTasks,
          completedTasks: state.completedTasks,
          removedTasks: List.from(state.removedTasks)..remove(event.task)),
    );
  }
  // List.from(state.allTasks)..remove(event.task))

  void _onRemoveTask(RemoveTask event, Emitter<TaskBlocState> emit) {
    final state = this.state;
    emit(
      TaskBlocState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true)),
      ),
    );
  }

  @override
  TaskBlocState? fromJson(Map<String, dynamic> json) {
    return TaskBlocState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskBlocState state) {
    return state.toMap();
  }
}
