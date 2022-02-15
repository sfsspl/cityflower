import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/user/domain/entity/my_cf_card_entity.dart';
import 'package:city_flower/features/user/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class UserRepository {
  Future<bool> checkUserLoggedIn();

  Future<Either<Failure, UserEntity>> getUserData();

  Future<Either<Failure, UserVerificationResponse>> login(
      {@required String phoneNumber, @required String password});

  Future<void> saveUserData({@required UserEntity userEntity});

  Future<void> saveUserToken({@required String token});

  Future<Either<Failure, MyCFCardEntity>> getMyCFCardDetails();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure,String>> register({@required String number});

  Future<Either<Failure,void>> setNewPassword({@required String token,@required String password});
}
