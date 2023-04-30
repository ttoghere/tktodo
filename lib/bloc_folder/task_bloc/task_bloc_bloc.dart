import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
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
        allTasks: List.from(state.allTasks)..add(event.task),
      ),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskBlocState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(task);
    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));
    emit(TaskBlocState(allTasks: allTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskBlocState> emit) {
    final state = this.state;
    emit(
      TaskBlocState(allTasks: List.from(state.allTasks)..remove(event.task)),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskBlocState> emit) {}

  @override
  TaskBlocState? fromJson(Map<String, dynamic> json) {
    return TaskBlocState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskBlocState state) {
    return state.toMap();
  }
}
