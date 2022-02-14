part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  final String mobileNumber;

  RegisterEvent({@required this.mobileNumber});

  @override
  List<Object> get props => [mobileNumber];
}
