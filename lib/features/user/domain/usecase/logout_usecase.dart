import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  final UserRepository userRepository;

  LogoutUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await userRepository.logout();
  }
}
