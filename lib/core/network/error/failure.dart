import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  String message;
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure{
  @override
  String message = 'Something went wrong';
}


class CacheFailure extends Failure {
  @override
  String message = 'Cache Failure';
}

class NetworkFailure extends Failure{
  @override
  set message(String _message) {
    super.message = _message;
  }
  @override
  String get message => 'No Internet Connectivity';
}

class UserSessionFailure extends Failure{
  @override
  set message(String _message) {
    super.message = _message;
  }

  @override
  String get message => 'User not logged in';
}

class AuthFailure extends Failure{
  @override
  set message(String _message) {
    super.message = _message;
  }

  @override
  String get message => 'UnAuthenticated';
}