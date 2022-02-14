import 'package:city_flower/features/splash/domain/repository/splash_repository.dart';
import 'package:meta/meta.dart';

class SetFirstLaunchComplete {
  final SplashRepository splashRepository;

  SetFirstLaunchComplete({@required this.splashRepository});

  Future<void> call() async {
    return await splashRepository.setFirstLaunchComplete();
  }
}
