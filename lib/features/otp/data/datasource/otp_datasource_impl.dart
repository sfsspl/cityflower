import 'dart:convert';

import 'package:city_flower/core/network/api_endpoints.dart';
import 'package:city_flower/core/network/http_call.dart';
import 'package:city_flower/core/network/http_error_handler.dart';
import 'package:city_flower/features/otp/data/datasource/otp_datasource.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/user/data/model/user_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
class OTPDataSourceImpl implements OTPDataSource{
  final http.Client client;

  OTPDataSourceImpl({@required this.client});

  @override
  Future<OtpResponse> verifyOTP({String email, String otp}) async{
    var params = <String, String>{
      "email": email,
      "otp":otp
    };

    var response = await httpPostRequest(
        httpClient: client, url: OTP_VERIFICATION_API_ENDPOINT, params: params);
    if (response.statusCode == 200) {
      return OtpResponse.fromJson(json.decode(response.body));
    }
    handleError(response);
  }
}