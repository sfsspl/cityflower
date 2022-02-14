part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterationInitiatedState extends RegisterState{
  @override
  List<Object> get props => [];
}

class RegistrationFailedState extends RegisterState{
  final Failure failure;

  RegistrationFailedState({@required this.failure});

  @override
  List<Object> get props => [failure];
}

class RegistrationSuccessState extends RegisterState{
  final String message;

  RegistrationSuccessState({@required this.message});
  @override
  List<Object> get props => [message];
}