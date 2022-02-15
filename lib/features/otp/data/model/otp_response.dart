import 'package:city_flower/features/user/data/model/user_data_model.dart';

class UserVerificationResponse {
  String message;
  UserDataModel user;
  String token;

  UserVerificationResponse({this.message, this.user, this.token});

  UserVerificationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new UserDataModel.fromJson(json['user']) : null;
    token = json['token'];
  }
  @override
  String toString() {
    return 'UserVerificationResponse{message: $message, user: $user, token: $token}';
  }
}


