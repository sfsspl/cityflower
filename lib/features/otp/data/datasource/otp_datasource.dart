import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/user/data/model/user_data_model.dart';
import 'package:meta/meta.dart';

abstract class OTPDataSource {
  Future<OtpResponse> verifyOTP(
      {@required String email, @required String otp});
}
