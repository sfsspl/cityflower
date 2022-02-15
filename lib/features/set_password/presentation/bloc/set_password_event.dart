part of 'set_password_bloc.dart';

abstract class SetPasswordEvent extends Equatable {
  const SetPasswordEvent();
}

class SetNewPasswordEvent extends SetPasswordEvent {
  final String password, token;
  final UserVerificationResponse userVerificationResponse;
  final REQUEST_TYPE requestType;

  SetNewPasswordEvent(
      {this.userVerificationResponse,
      @required this.token,
      @required this.password,
      @required this.requestType});

  @override
  List<Object> get props => [userVerificationResponse, password, requestType,token];
}

class SaveUserDataEvent extends SetPasswordEvent {
  final UserVerificationResponse userVerificationResponse;

  SaveUserDataEvent({@required this.userVerificationResponse});

  @override
  List<Object> get props => [userVerificationResponse];
}
