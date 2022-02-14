import 'package:city_flower/core/network/error/exceptions.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/network/network_info.dart';
import 'package:city_flower/features/points_history/data/datasource/points_history_datasource.dart';
import 'package:city_flower/features/points_history/domain/entity/points_history_entity.dart';
import 'package:city_flower/features/points_history/domain/respository/points_history_repository.dart';
import 'package:city_flower/features/user/data/datasource/user_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class PointsHistoryRepositoryImpl implements PointsHistoryRepository {
  final UserDataSource userDataSource;
  final NetworkInfo networkInfo;
  final PointsHistoryDataSource pointsHistoryDataSource;

  PointsHistoryRepositoryImpl(
      {@required this.userDataSource,
      @required this.networkInfo,
      @required this.pointsHistoryDataSource});

  @override
  Future<Either<Failure, List<PointsHistoryEntity>>> getPointsHistory(
      {int itemsPerPage}) async {
    if (await networkInfo.isConnected) {
      try {
        final _token = await userDataSource.getToken();
        return Right(await pointsHistoryDataSource.getPointsHistory(
            token: _token, itemsPerPage: itemsPerPage));
      } on AuthException {
        return Left(AuthFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
