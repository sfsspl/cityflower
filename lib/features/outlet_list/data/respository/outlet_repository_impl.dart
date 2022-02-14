import 'package:city_flower/core/network/error/exceptions.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/network/network_info.dart';
import 'package:city_flower/features/outlet_list/data/datasource/outlet_datasource.dart';
import 'package:city_flower/features/outlet_list/domain/entity/outlet_list_entity.dart';
import 'package:city_flower/features/outlet_list/domain/repository/outlet_repository.dart';
import 'package:city_flower/features/user/data/datasource/user_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class OutletRepositoryImpl implements OutletRepository {
  final NetworkInfo networkInfo;
  final UserDataSource userDataSource;
  final OutletDataSource outletDataSource;

  OutletRepositoryImpl(
      {@required this.networkInfo,
      @required this.userDataSource,
      @required this.outletDataSource});

  @override
  Future<Either<Failure, List<OutletListEntity>>> getOutletList(
      {int countryId, String city}) async {
    if (await networkInfo.isConnected) {
      try {
        final _token = await userDataSource.getToken();
        return Right(await outletDataSource.getOutletList(
            token: _token, countryId: countryId,city: city));
      } on AuthException {
        return Left(AuthFailure());
      } on ServerException catch (ex) {
        return Left(ServerFailure()..message = ex.message);
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
