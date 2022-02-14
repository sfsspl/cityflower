import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/points_history/domain/entity/points_history_entity.dart';
import 'package:city_flower/features/points_history/domain/respository/points_history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetPointsHistoryUseCase extends UseCase<List<PointsHistoryEntity>, int> {
  final PointsHistoryRepository pointsHistoryRepository;

  GetPointsHistoryUseCase({@required this.pointsHistoryRepository});

  @override
  Future<Either<Failure, List<PointsHistoryEntity>>> call(int params) async {
    return await pointsHistoryRepository.getPointsHistory(itemsPerPage: params);
  }
}
