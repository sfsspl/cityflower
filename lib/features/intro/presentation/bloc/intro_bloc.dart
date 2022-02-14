import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/features/intro/domain/usecase/set_first_launch_complete.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'intro_event.dart';

part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final SetFirstLaunchComplete setFirstLaunchComplete;

  IntroBloc({@required this.setFirstLaunchComplete}) : super(IntroInitial());

  @override
  Stream<IntroState> mapEventToState(
    IntroEvent event,
  ) async* {
    if (event is SetFirstLaunchCompleteEvent) {
      await setFirstLaunchComplete();
    }
  }
}
