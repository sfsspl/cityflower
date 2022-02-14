import 'package:city_flower/core/network/error/exceptions.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/network/network_info.dart';
import 'package:city_flower/features/user/data/datasource/user_datasource.dart';
import 'package:city_flower/features/user/domain/entity/my_cf_card_entity.dart';
import 'package:city_flower/features/user/domain/entity/user_entity.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {@required this.userDataSource, @required this.networkInfo});

  @override
  Future<bool> checkUserLoggedIn() async {
    return await userDataSource.checkUserLoggedIn();
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      UserEntity _userData = await userDataSource.getUserData();
      return Right(_userData);
    } on AuthException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, String>> login(
      {String phoneNumber, String password}) async {
    if (await networkInfo.isConnected) {
      try {
        String loginMessage = await userDataSource.login(
            phoneNumber: phoneNumber, password: password);
        return Right(loginMessage);
      } on AuthException {
        return Left(AuthFailure());
      } on ServerException catch (ex) {
        return Left(ServerFailure()..message = ex.message);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<void> saveUserData({UserEntity userEntity}) async {
    await userDataSource.saveUserData(userDataModel: userEntity);
  }

  @override
  Future<void> saveUserToken({String token}) async {
    await userDataSource.saveUserToken(token: token);
  }

  @override
  Future<Either<Failure, MyCFCardEntity>> getMyCFCardDetails() async {
    if (await networkInfo.isConnected) {
      try {
        final _token = await userDataSource.getToken();
        MyCFCardEntity response =
            await userDataSource.getMyCFCardDetails(token: _token);
        return Right(response);
      } on AuthException {
        return Left(AuthFailure());
      } on ServerException catch (ex) {
        return Left(ServerFailure()..message = ex.message);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (await networkInfo.isConnected) {
      final _token = await userDataSource.getToken();
      try {
        await userDataSource.logout(token: _token);
        await userDataSource.clearUserData();
        return Right(null);
      } on AuthException {
        //TODO change this failure implementation
        await userDataSource.clearUserData();
        return Right(null);
        return Left(AuthFailure());
      } on ServerException catch (ex) {
        await userDataSource.clearUserData();
        return Right(null);
        print('repo logout $ex');
        return Left(ServerFailure()..message = ex.message);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> register({String number}) async {
    if (await networkInfo.isConnected) {
      try {
        String loginMessage = await userDataSource.register(number: number);
        return Right(loginMessage);
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
