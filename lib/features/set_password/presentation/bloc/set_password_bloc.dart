import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/register/presentation/ui/register_page.dart';
import 'package:city_flower/features/set_password/domain/entity/set_password_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/get_user_token.dart';
import 'package:city_flower/features/user/domain/usecase/save_user_data_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/save_user_token.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'set_password_event.dart';

part 'set_password_state.dart';

class SetPasswordBloc extends Bloc<SetPasswordEvent, SetPasswordState> {
  SetPasswordUseCase setPasswordUseCase;
  SaveUserDataUseCase saveUserDataUseCase;
  SaveUserTokenUseCase saveUserTokenUseCase;
  GetUserTokenUseCase getUserTokenUseCase;

  SetPasswordBloc(
      {@required this.setPasswordUseCase,
      @required this.saveUserDataUseCase,
      @required this.saveUserTokenUseCase,
      @required this.getUserTokenUseCase})
      : super(SetPasswordInitial());

  @override
  Stream<SetPasswordState> mapEventToState(
    SetPasswordEvent event,
  ) async* {
    if (event is SetNewPasswordEvent) {
      yield SetPasswordStarted();
      String _token = event.token;
      if (_token == null) {
        _token = await getUserTokenUseCase(NoParams());
      }
      final _result = await setPasswordUseCase(
          SetPasswordParam(token: _token, password: event.password));
      yield* _result.fold((l) async* {
        yield SetPasswordFailed(failure: l);
      }, (r) async* {
        if (event.requestType == REQUEST_TYPE.CHANGE_PASSWORD) {
          yield SetPasswordSuccessful();
        } else {
          add(SaveUserDataEvent(
              userVerificationResponse: event.userVerificationResponse));
        }
      });
    }
    if (event is SaveUserDataEvent) {
      await saveUserDataUseCase(event.userVerificationResponse.user);
      await saveUserTokenUseCase(event.userVerificationResponse.token);
      yield SetPasswordSuccessful();
    }
  }
}
