import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/vo/resource.dart';
import 'package:city_flower/features/user/domain/usecase/login_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/save_user_data_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/save_user_token.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final SaveUserDataUseCase saveUserDataUseCase;
  final SaveUserTokenUseCase saveUserTokenUseCase;

  LoginBloc(
      {@required this.loginUseCase,
      @required this.saveUserDataUseCase,
      @required this.saveUserTokenUseCase})
      : super(LoginState(login: null));

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield state.copy(login: Resource.loading());
      final _result = await loginUseCase(LoginParams(
          phoneNumber: event.phoneNumber, password: event.password));
      yield* _result.fold((failure) async* {
        yield state.copy(login: Resource.error(failure: failure));
      }, (result) async* {
        await saveUserDataUseCase(result.user);
        await saveUserTokenUseCase(result.token);
        yield state.copy(login: Resource.success(data: result));
      });
    }
  }
}
