import 'package:equatable/equatable.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/models/task.dart';
import 'package:tktodo/repositories/tasks/task_repository.dart';

part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TaskBlocBloc extends Bloc<TaskBlocEvent, TaskBlocState> {
  final TaskRepository _taskRepository;
  TaskBlocBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const TaskBlocState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
    on<GetAllTasks>(_onGetAllTasks);
  }

  void _onGetAllTasks(GetAllTasks event, Emitter<TaskBlocState> emit) async {
    List<Task> pendingTasks = [];
    List<Task> completedTasks = [];
    List<Task> favoriteTasks = [];
    List<Task> removedTasks = [];
    await _taskRepository.getTasks().then((value) {
      for (var task in value) {
        if (task.isDeleted == true) {
          removedTasks.add(task);
        } else {
          if (task.isFavorite == true) {
            favoriteTasks.add(task);
          } else if (task.isDone == true) {
            completedTasks.add(task);
          } else {
            pendingTasks.add(task);
          }
        }
      }
    });
    emit(TaskBlocState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: removedTasks,
    ));
  }

  void _onAddTask(AddTask event, Emitter<TaskBlocState> emit) async {
    // final state = this.state;
    await _taskRepository.addTask(task: event.task);
    // emit(
    //   TaskBlocState(
    //     pendingTasks: List.from(state.pendingTasks)..add(event.task),
    //     removedTasks: state.removedTasks,
    //     completedTasks: state.completedTasks,
    //     favoriteTasks: state.favoriteTasks,
    //   ),
    // );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskBlocState> emit) async {
    // final state = this.state;
    // final task = event.task;
    // List<Task> pendingTasks = state.pendingTasks;
    // List<Task> completedTasks = state.completedTasks;
    // task.isDone == false
    //     ? {
    //         pendingTasks = List.from(pendingTasks)..remove(task),
    //         completedTasks = List.from(completedTasks)
    //           ..insert(0, task.copyWith(isDone: true))
    //       }
    //     : {
    //         completedTasks = List.from(completedTasks)..remove(task),
    //         pendingTasks = List.from(pendingTasks)
    //           ..insert(0, task.copyWith(isDone: false))
    //       };
    // emit(TaskBlocState(
    //   pendingTasks: pendingTasks,
    //   removedTasks: state.removedTasks,
    //   favoriteTasks: state.favoriteTasks,
    //   completedTasks: completedTasks,
    // ));
    Task updatedTask = event.task.copyWith(isDone: !event.task.isDone!);
    await _taskRepository.updateTask(task: updatedTask);
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskBlocState> emit) async {
    // final state = this.state;
    // emit(
    //   TaskBlocState(
    //       pendingTasks: state.pendingTasks,
    //       favoriteTasks: state.favoriteTasks,
    //       completedTasks: state.completedTasks,
    //       removedTasks: List.from(state.removedTasks)..remove(event.task)),
    // );
    await _taskRepository.deleteTask();
  }
  // List.from(state.allTasks)..remove(event.task))

  void _onDeleteAllTask(
      DeleteAllTasks event, Emitter<TaskBlocState> emit) async {
    // final state = this.state;
    // emit(
    //   TaskBlocState(
    //     removedTasks: List.from(state.removedTasks)..clear(),
    //     pendingTasks: state.pendingTasks,
    //     completedTasks: state.completedTasks,
    //     favoriteTasks: state.favoriteTasks,
    //   ),
    // );
    await _taskRepository.deleteAllRemovedTasks(taskList: state.removedTasks);
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskBlocState> emit) async {
    // final state = this.state;
    // emit(
    //   TaskBlocState(
    //     pendingTasks: List.from(state.pendingTasks)..remove(event.task),
    //     favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
    //     completedTasks: List.from(state.completedTasks)..remove(event.task),
    //     removedTasks: List.from(state.removedTasks)
    //       ..add(event.task.copyWith(isDeleted: true)),
    //   ),
    // );
    Task removedTask = event.task.copyWith(isDeleted: true);
    await _taskRepository.updateTask(task: removedTask);
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TaskBlocState> emit) async {
    // final state = this.state;
    // List<Task> pendingTasks = state.pendingTasks;
    // List<Task> completedTasks = state.completedTasks;
    // List<Task> favoriteTasks = state.favoriteTasks;
    // if (event.task.isDone == false) {
    //   if (event.task.isFavorite == false) {
    //     var taskIndex = pendingTasks.indexOf(event.task);
    //     pendingTasks = List.from(pendingTasks)
    //       ..remove(event.task)
    //       ..insert(taskIndex, event.task.copyWith(isFavorite: true));
    //     favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
    //   } else {
    //     var taskIndex = pendingTasks.indexOf(event.task);
    //     pendingTasks = List.from(pendingTasks)
    //       ..remove(event.task)
    //       ..insert(taskIndex, event.task.copyWith(isFavorite: false));
    //     favoriteTasks.remove(event.task);
    //   }
    // } else {
    //   if (event.task.isFavorite == false) {
    //     var taskIndex = completedTasks.indexOf(event.task);
    //     completedTasks = List.from(completedTasks)
    //       ..remove(event.task)
    //       ..insert(taskIndex, event.task.copyWith(isFavorite: true));
    //     favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
    //   } else {
    //     var taskIndex = completedTasks.indexOf(event.task);
    //     completedTasks = List.from(completedTasks)
    //       ..remove(event.task)
    //       ..insert(taskIndex, event.task.copyWith(isFavorite: false));
    //     favoriteTasks.remove(event.task);
    //   }
    // }
    // emit(
    //   TaskBlocState(
    //     pendingTasks: pendingTasks,
    //     favoriteTasks: favoriteTasks,
    //     completedTasks: completedTasks,
    //     removedTasks: state.removedTasks,
    //   ),
    // );
    Task favTask = event.task.copyWith(isFavorite: !event.task.isFavorite!);
    await _taskRepository.updateTask(task: favTask);
  }

  void _onEditTask(EditTask event, Emitter<TaskBlocState> emit) async {
    // final state = this.state;
    // List<Task> favouriteTasks = state.favoriteTasks;
    // if (event.oldTask.isFavorite == true) {
    //   favouriteTasks
    //     ..remove(event.oldTask)
    //     ..insert(0, event.newTask);
    // }
    // emit(TaskBlocState(
    //   pendingTasks: List.from(state.pendingTasks)
    //     ..remove(event.oldTask)
    //     ..insert(0, event.newTask),
    //   completedTasks: state.completedTasks..remove(event.oldTask),
    //   favoriteTasks: favouriteTasks,
    //   removedTasks: state.removedTasks,
    // ));
    await _taskRepository.updateTask(task: event.newTask);
  }

  void _onRestoreTask(RestoreTask event, Emitter<TaskBlocState> emit) async {
    // final state = this.state;
    // emit(
    //   TaskBlocState(
    //     removedTasks: List.from(state.removedTasks)..remove(event.task),
    //     pendingTasks: List.from(state.pendingTasks)
    //       ..insert(
    //           0,
    //           event.task.copyWith(
    //               isDeleted: false, isDone: false, isFavorite: false)),
    //     completedTasks: state.completedTasks,
    //     favoriteTasks: state.favoriteTasks,
    //   ),
    // );
    Task restoredTask = event.task.copyWith(
      isDeleted: false,
      isDone: false,
      date: DateTime.now().toString(),
      isFavorite: false,
    );
    await _taskRepository.updateTask(task: restoredTask);
  }
}
