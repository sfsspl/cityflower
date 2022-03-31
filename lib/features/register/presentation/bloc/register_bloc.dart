import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/features/register/domain/usecase/register_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({@required this.registerUseCase}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterEvent) {
      yield RegisterationInitiatedState();
      final _result = await registerUseCase(RegisterParams(number: event.mobileNumber,isForgotPassword: event.isForgotPassword));
      yield* _result.fold((l) async* {
        yield RegistrationFailedState(failure: l);
      }, (r) async* {
        yield RegistrationSuccessState(message: r);
      });
    }
  }
}
