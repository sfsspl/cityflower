import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:city_flower/features/promotion/domain/repository/promotions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetPromotionUseCase extends UseCase<List<PromotionEntity>,PROMOTION_TYPE>{
  final PromotionsRepository promotionsRepository;

  GetPromotionUseCase({@required this.promotionsRepository});
  @override
  Future<Either<Failure, List<PromotionEntity>>> call(PROMOTION_TYPE params)async {
   return await promotionsRepository.getPromotions(type: params);
  }
}