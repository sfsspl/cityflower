import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class LoginUseCase extends UseCase<UserVerificationResponse, LoginParams> {
  final UserRepository userRepository;

  LoginUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, UserVerificationResponse>> call(LoginParams params) async {
    return await userRepository.login(
        phoneNumber: params.phoneNumber, password: params.password);
  }
}

class LoginParams {
  final String phoneNumber, password;

  LoginParams({@required this.phoneNumber, @required this.password});
}
