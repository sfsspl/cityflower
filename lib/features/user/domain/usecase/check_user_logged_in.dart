import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:meta/meta.dart';

class CheckUserLoggedInUseCase {
  final UserRepository userRepository;

  CheckUserLoggedInUseCase({@required this.userRepository});

  Future<bool> call() async {
    return await userRepository.checkUserLoggedIn();
  }
}
