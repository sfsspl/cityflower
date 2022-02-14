
abstract class SplashDataSource{
  Future<bool> isFirstLaunch();
  Future<void> setFirstLaunchComplete();
}