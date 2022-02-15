import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/otp/domain/repository/otp_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class VerifyOTPUseCase
    extends UseCase<UserVerificationResponse, OTPVerificationParams> {
  final OTPRepository otpRepository;

  VerifyOTPUseCase({@required this.otpRepository});

  @override
  Future<Either<Failure, UserVerificationResponse>> call(
      OTPVerificationParams params) async {
    final _response  = await otpRepository.verifyOTP(
        phoneNumber: params.phoneNumber, otp: params.otp);
    print('usecase response $_response');
    return _response;
  }
}

class OTPVerificationParams {
  final String phoneNumber, otp;

  OTPVerificationParams({@required this.phoneNumber, @required this.otp});
}
