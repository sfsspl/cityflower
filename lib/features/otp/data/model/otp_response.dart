import 'package:city_flower/features/user/data/model/user_data_model.dart';

class OtpResponse {
  String message;
  UserDataModel user;
  String token;

  OtpResponse({this.message, this.user, this.token});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new UserDataModel.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}


