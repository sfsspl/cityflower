import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class SetPasswordUseCase extends UseCase<void, SetPasswordParam> {
  final UserRepository userRepository;

  SetPasswordUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, void>> call(SetPasswordParam params) async {
    return await userRepository.setNewPassword(
        token: params.token, password: params.password);
  }
}

class SetPasswordParam {
  final String token, password;

  SetPasswordParam({@required this.token, @required this.password});
}
