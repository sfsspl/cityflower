import 'package:city_flower/core/network/error/exceptions.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/network/network_info.dart';
import 'package:city_flower/features/otp/data/datasource/otp_datasource.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/otp/domain/repository/otp_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class OTPRepositoryImpl implements OTPRepository {
  final NetworkInfo networkInfo;
  final OTPDataSource otpDataSource;

  OTPRepositoryImpl({@required this.networkInfo, @required this.otpDataSource});

  @override
  Future<Either<Failure, OtpResponse>> verifyOTP(
      {String email, String otp}) async {
    if (await networkInfo.isConnected) {
      try {
        OtpResponse userEntity =
            await otpDataSource.verifyOTP(email: email, otp: otp);
        return Right(userEntity);
      } on ServerException catch (ex) {
        return Left(ServerFailure()..message = ex.message);
      }
    } else {
      throw Left(NetworkFailure());
    }
  }
}
