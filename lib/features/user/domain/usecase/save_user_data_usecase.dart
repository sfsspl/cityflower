import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/data/model/user_data_model.dart';
import 'package:city_flower/features/user/domain/entity/user_entity.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class SaveUserDataUseCase extends UseCase<void,UserEntity>{
  final UserRepository userRepository;

  SaveUserDataUseCase({@required this.userRepository});
  @override
  Future<Either<Failure, void>> call(UserEntity params)async {
     await userRepository.saveUserData(userEntity: params);
  }

}