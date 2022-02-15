import 'dart:convert';

import 'package:city_flower/core/network/api_endpoints.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/network/http_call.dart';
import 'package:city_flower/core/network/http_error_handler.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/user/data/datasource/user_datasource.dart';
import 'package:city_flower/features/user/data/model/my_cf_card_model.dart';
import 'package:city_flower/features/user/data/model/user_data_model.dart';
import 'package:city_flower/features/user/domain/entity/my_cf_card_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataSourceImpl implements UserDataSource {
  final SharedPreferences preferences;
  final http.Client httpClient;

  UserDataSourceImpl({@required this.preferences, @required this.httpClient});

  @override
  Future<bool> checkUserLoggedIn() async {
    return await Future.value(preferences.getString("user_data") != null);
  }

  @override
  Future<UserDataModel> getUserData() async {
    var userJsonData = await preferences.getString('user_data');
    print('user_data ${userJsonData}');
    if (userJsonData != null) {
      UserDataModel data = UserDataModel.fromJson(json.decode(userJsonData));
      return data;
    } else
      throw AuthFailure();
  }

  @override
  Future<UserVerificationResponse> login(
      {String phoneNumber, String password}) async {
    var params = <String, String>{
      "country_id": COUNTRY_ID,
      "mobile_number": phoneNumber,
      "password": password
    };

    var response = await httpPostRequest(
        httpClient: httpClient, url: LOGIN_API_ENDPOINT, params: params);
    debugPrint('login response ${response.body} ');
    if (response.statusCode == 200) {
      return UserVerificationResponse.fromJson(json.decode(response.body));
    }
    handleError(response);
  }

  @override
  Future<void> saveUserData({UserDataModel userDataModel}) async {
    final _jsonString = json.encode(userDataModel);
    await preferences.setString("user_data", _jsonString);
  }

  @override
  Future<void> saveUserToken({String token}) async {
    await preferences.setString("token", token);
  }

  @override
  Future<String> getToken() async {
    return Future.value(preferences.getString('token'));
  }

  @override
  Future<MyCFCardEntity> getMyCFCardDetails({String token}) async {
    var response = await httpGetRequest(
        httpClient: httpClient, url: MY_CF_CARD_API_ENDPOINT, token: token);
    if (response.statusCode == 200) {
      return MyCfCardModel.fromJson(json.decode(response.body)['card']);
    }
    handleError(response);
  }

  @override
  Future<void> logout({String token}) async {
    var response = await httpPostRequest(
        httpClient: httpClient, url: LOGOUT_API_ENDPOINT, token: token);
    if (response.statusCode == 200) {
      return Right(null);
    }
    handleError(response);
  }

  @override
  Future<void> clearUserData() async {
    await preferences.clear();
  }

  @override
  Future<String> register({String number}) async {
    var params = <String, String>{
      "country_id": COUNTRY_ID,
      "mobile_number": number,
    };

    var response = await httpPostRequest(
        httpClient: httpClient, url: REGISTER_API_ENDPOINT, params: params);
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return json.decode(response.body)['message'];
    }
    handleError(response);
  }

  @override
  Future<void> setPassword({String token, String password}) async {
    var params = <String, String>{
      "new_password": password,
    };

    var response = await httpPostRequest(
        httpClient: httpClient,
        url: SET_PASSWORD_API_ENDPOINT,
        params: params,
        token: token);
    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    }
    handleError(response);
  }
}
