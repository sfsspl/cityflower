import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class RegisterUseCase extends UseCase<String, String> {
  final UserRepository userRepository;

  RegisterUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, String>> call(String params) {
    return userRepository.register(number: params);
  }
}
