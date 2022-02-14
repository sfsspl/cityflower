import 'package:city_flower/features/splash/data/datasource/splash_data_source.dart';
import 'package:city_flower/features/splash/domain/repository/splash_repository.dart';
import 'package:meta/meta.dart';
class SplashRepositoryImpl implements SplashRepository{
  final SplashDataSource dataSource;

  SplashRepositoryImpl({@required this.dataSource});
  @override
  Future<bool> isFirstLaunch() async{
    return await dataSource.isFirstLaunch();
  }

  @override
  Future<void> setFirstLaunchComplete()async {
     await dataSource.setFirstLaunchComplete();
  }
}
