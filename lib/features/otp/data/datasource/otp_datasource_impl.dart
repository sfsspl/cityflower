import 'dart:convert';

import 'package:city_flower/core/network/api_endpoints.dart';
import 'package:city_flower/core/network/http_call.dart';
import 'package:city_flower/core/network/http_error_handler.dart';
import 'package:city_flower/features/otp/data/datasource/otp_datasource.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class OTPDataSourceImpl implements OTPDataSource {
  final http.Client client;

  OTPDataSourceImpl({@required this.client});

  @override
  Future<UserVerificationResponse> verifyOTP({String phoneNumber, String otp}) async {
    var params = <String, String>{
      'country_id': COUNTRY_ID,
      "mobile_number": phoneNumber,
      "otp": otp,
    };
    print('params $params}');
    var response = await httpPostRequest(
        httpClient: client, url: OTP_VERIFICATION_API_ENDPOINT, params: params);
    if (response.statusCode == 200) {
      print('verifyOTP response ${response.body}');
      return UserVerificationResponse.fromJson(json.decode(response.body));
    }
    handleError(response);
  }
}
