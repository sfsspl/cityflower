import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/features/points_history/domain/entity/points_history_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class PointsHistoryRepository {
  Future<Either<Failure, List<PointsHistoryEntity>>> getPointsHistory(
      {@required int itemsPerPage});
}
