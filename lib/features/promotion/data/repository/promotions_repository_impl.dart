import 'package:city_flower/core/network/error/exceptions.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/network/network_info.dart';
import 'package:city_flower/features/promotion/data/datasource/promotion_data_source.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:city_flower/features/promotion/domain/repository/promotions_repository.dart';
import 'package:city_flower/features/user/data/datasource/user_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class PromotionsRepositoryImpl implements PromotionsRepository {
  final NetworkInfo networkInfo;
  final PromotionsDataSource promotionDataSource;
  final UserDataSource userDataSource;

  PromotionsRepositoryImpl(
      {@required this.networkInfo,
      @required this.promotionDataSource,
      @required this.userDataSource});

  @override
  Future<Either<Failure, List<PromotionEntity>>> getPromotions(
      {PROMOTION_TYPE type}) async {
    if (await networkInfo.isConnected) {
      try {
        final _token = await userDataSource.getToken();
        final _promotions =
            await promotionDataSource.getPromotions(type: type, token: _token);
        return Right(_promotions);
      } on AuthException catch (ex) {
        return Left(AuthFailure()..message = ex.message);
      }on ServerException catch(ex){
        return Left(ServerFailure()..message = ex.message);
      } on Exception catch (ex) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
