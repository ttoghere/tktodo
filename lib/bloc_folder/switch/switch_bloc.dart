
import 'package:equatable/equatable.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';


part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchInitial(switchValue: false)) {
    on<SwitchOnEvent>(_switchOn);
    on<SwitchOffEvent>(_switchOff);
  }

  void _switchOff(SwitchOffEvent event, Emitter<SwitchState> emit) {
    emit(const SwitchState(switchValue: false));
  }

  void _switchOn(SwitchOnEvent event, Emitter<SwitchState> emit) {
    emit(const SwitchState(switchValue: true));
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}
