part of 'login_bloc.dart';

class LoginState extends Equatable {
  final Resource login;

  LoginState({@required this.login});

  @override
  List<Object> get props => [login];

  LoginState copy({Resource login}) {
    return LoginState(login: login ?? this.login);
  }
}
