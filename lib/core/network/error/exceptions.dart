abstract class MyException implements Exception {
  String message = 'Something went wrong';
}

class ServerException implements MyException {
  @override
  String message = 'Something went wrong';
}

class CacheException implements MyException {
  @override
  String message;
}

class AuthException implements MyException {
  @override
  String message = 'Authentication failed';
}
