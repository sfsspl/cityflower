import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class SaveUserTokenUseCase extends UseCase<void, String> {
  final UserRepository userRepository;

  SaveUserTokenUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, void>> call(String params) async {
    await userRepository.saveUserToken(token: params);
  }
}
