part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  final String mobileNumber;
  final bool isForgotPassword;

  RegisterEvent({@required this.mobileNumber, @required this.isForgotPassword});

  @override
  List<Object> get props => [mobileNumber, isForgotPassword];
}
