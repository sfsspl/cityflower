part of 'otp_bloc.dart';

class OtpState extends Equatable {
  final Resource otpVerificationResource;

  OtpState({this.otpVerificationResource});

  @override
  List<Object> get props => [otpVerificationResource];

  factory OtpState.initial() {
    return OtpState();
  }

  OtpState copy({Resource otpVerificationResource}) {
    return OtpState(
        otpVerificationResource:
            otpVerificationResource ?? this.otpVerificationResource);
  }
}
