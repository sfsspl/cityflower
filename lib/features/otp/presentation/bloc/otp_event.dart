part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpEvent extends OtpEvent {
  final String email, otp;

  VerifyOtpEvent({@required this.email, @required this.otp});

  @override
  List<Object> get props => [email, otp];
}
