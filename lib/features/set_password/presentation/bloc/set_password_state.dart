part of 'set_password_bloc.dart';

abstract class SetPasswordState extends Equatable {
  const SetPasswordState();
}

class SetPasswordInitial extends SetPasswordState {
  @override
  List<Object> get props => [];
}

class SetPasswordSuccessful extends SetPasswordState {
  @override
  List<Object> get props => [];
}

class SetPasswordFailed extends SetPasswordState {
  final Failure failure;

  SetPasswordFailed({@required this.failure});

  @override
  List<Object> get props => [failure];
}

class SetPasswordStarted extends SetPasswordState {
  @override
  List<Object> get props => [];
}
