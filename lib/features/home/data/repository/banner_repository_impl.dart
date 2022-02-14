import 'package:city_flower/core/network/error/exceptions.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/network/network_info.dart';
import 'package:city_flower/features/home/data/datasource/banner_datasource.dart';
import 'package:city_flower/features/home/domain/repository/banner_repository.dart';
import 'package:city_flower/features/user/data/datasource/user_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerDataSource bannerDataSource;
  final NetworkInfo networkInfo;
  final UserDataSource userDataSource;

  BannerRepositoryImpl(
      {@required this.bannerDataSource,
      @required this.networkInfo,
      @required this.userDataSource});

  @override
  Future<Either<Failure, List<String>>> getBanners() async {
    if (await networkInfo.isConnected) {
      final token = await userDataSource.getToken();
      try{
        return Right(await bannerDataSource.getBanners(token: token));
      }on AuthException catch(ex){
        return Left(AuthFailure());
      } on ServerException catch (ex){
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
