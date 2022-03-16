import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
class GetUserTokenUseCase {
  final UserRepository userRepository;

  GetUserTokenUseCase({@required this.userRepository});
  @override
  Future<String> call(NoParams params) async{
    return await userRepository.getToken();
  }
}