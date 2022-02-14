import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class PromotionsRepository {
  Future<Either<Failure, List<PromotionEntity>>> getPromotions(
      {@required PROMOTION_TYPE type});
}
