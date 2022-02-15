import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/user/data/model/user_data_model.dart';
import 'package:city_flower/features/user/domain/entity/my_cf_card_entity.dart';
import 'package:meta/meta.dart';

abstract class UserDataSource {
  Future<bool> checkUserLoggedIn();

  Future<UserDataModel> getUserData();

  Future<UserVerificationResponse> login(
      {@required String phoneNumber, @required String password});

  Future<void> saveUserData({@required UserDataModel userDataModel});

  Future<void> saveUserToken({@required String token});

  Future<void> clearUserData();

  Future<String> getToken();

  Future<MyCFCardEntity> getMyCFCardDetails({@required String token});

  Future<void> logout({@required String token});

  Future<String> register({@required String number});

  Future<void> setPassword({@required String token, @required String password});
}
