import 'dart:developer';
import 'package:tktodo/bloc_folder/blocs.dart';


class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) log("Change: $change");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log("Transition: $transition");
  }
}
