import 'package:city_flower/features/splash/domain/repository/splash_repository.dart';
import 'package:meta/meta.dart';

class CheckFirstLaunch {
  final SplashRepository splashRepository;

  CheckFirstLaunch({@required this.splashRepository});

  Future<bool> call() async {
    return await splashRepository.isFirstLaunch();
  }
}
