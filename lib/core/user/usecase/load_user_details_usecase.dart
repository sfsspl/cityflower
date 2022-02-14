import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/domain/entity/user_entity.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class LoadUserDetailsUsecase extends UseCase<UserEntity, NoParams> {
  final UserRepository userRepository;

  LoadUserDetailsUsecase({@required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return userRepository.getUserData();
  }
}
