import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/vo/resource.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/core/user/usecase/load_user_details_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoadUserDetailsUsecase userDetailsUsecase;
  final LogoutUseCase logoutUseCase;

  UserBloc({@required this.userDetailsUsecase, @required this.logoutUseCase})
      : super(UserState.initial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUserDetailsEvent) {
      yield state.copy(userDetails: Resource.loading());
      var _result = await userDetailsUsecase(NoParams());
      yield* _result.fold((l) async* {
        yield state.copy(userDetails: Resource.error(failure: l));
      }, (r) async* {
        yield state.copy(userDetails: Resource.success(data: r));
      });
    }
    if (event is LogoutEvent) {
      await Future.delayed(Duration(milliseconds: 500));
      yield state.copy(logoutState: Resource.loading());
      var _result = await logoutUseCase(NoParams());
      yield* _result.fold((l) async* {
        yield state.copy(logoutState: Resource.error(failure: l));
      }, (r) async* {
        yield state.copy(logoutState: Resource.success());
        await this.close();
      });
    }
  }
}
