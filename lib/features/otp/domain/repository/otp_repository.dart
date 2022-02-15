import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/user/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class OTPRepository {
  Future<Either<Failure, UserVerificationResponse>> verifyOTP(
      {@required String phoneNumber, @required String otp});
}
