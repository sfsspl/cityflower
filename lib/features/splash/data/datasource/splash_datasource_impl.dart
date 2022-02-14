import 'package:city_flower/features/splash/data/datasource/splash_data_source.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashDataSourceImpl implements SplashDataSource {
  final SharedPreferences sharedPreferences;

  SplashDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<bool> isFirstLaunch() async {
    return await Future.value(
        sharedPreferences.getBool("is_first_launch") ?? true);
  }

  @override
  Future<void> setFirstLaunchComplete() async{
    await sharedPreferences.setBool("is_first_launch", false);
  }
}
