import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/otp/domain/repository/otp_repository.dart';
import 'package:city_flower/features/user/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class VerifyOTPUseCase extends UseCase<OtpResponse, OTPVerificationParams> {
  final OTPRepository otpRepository;

  VerifyOTPUseCase({@required this.otpRepository});

  @override
  Future<Either<Failure, OtpResponse>> call(OTPVerificationParams params) async {
    return await otpRepository.verifyOTP(email: params.email, otp: params.otp);
  }
}

class OTPVerificationParams {
  final String email, otp;

  OTPVerificationParams({@required this.email, @required this.otp});
}
