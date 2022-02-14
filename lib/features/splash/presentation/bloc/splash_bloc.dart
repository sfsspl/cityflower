import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/vo/resource.dart';
import 'package:city_flower/features/splash/domain/usecase/check_first_launch.dart';
import 'package:city_flower/features/user/domain/usecase/check_user_logged_in.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckFirstLaunch checkFirstLaunch;
  final CheckUserLoggedInUseCase userLoggedInUseCase;

  SplashBloc(
      {@required this.checkFirstLaunch, @required this.userLoggedInUseCase})
      : super(SplashState(firstLaunch: Resource.loading()));

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is CheckFirstLaunchEvent) {
      yield state.copy(firstLaunch: Resource.loading());
      var isFirstLaunch = await checkFirstLaunch();
      if (!isFirstLaunch) {
        bool isUserLoggedIn = await userLoggedInUseCase();
        yield state.copy(loggedIn: Resource.success(data: isUserLoggedIn));
      } else {
        yield state.copy(firstLaunch: Resource.success(data: isFirstLaunch));
      }
    }
  }
}
