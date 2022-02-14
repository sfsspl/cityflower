part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  final String phoneNumber, password;

  LoginEvent({@required this.phoneNumber, @required this.password});

  @override
  List<Object> get props => [phoneNumber, password];
}
