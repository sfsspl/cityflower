import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/domain/entity/my_cf_card_entity.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetMyCfCardDetails extends UseCase<MyCFCardEntity, NoParams> {
  final UserRepository userRepository;

  GetMyCfCardDetails({@required this.userRepository});

  @override
  Future<Either<Failure, MyCFCardEntity>> call(NoParams params) async {
    return await userRepository.getMyCFCardDetails();
  }
}
