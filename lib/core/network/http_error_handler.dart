import 'dart:convert';

import 'package:http/http.dart' as http;

import 'error/exceptions.dart';

void handleError(http.Response response) {
  print('response ${response.statusCode}');
  if (response.statusCode == 401) {
    final _message = json.decode(response.body)['message'];
    throw AuthException()..message = _message;
  } else if (response.statusCode == 422 ||
      response.statusCode == 500 ||
      response.statusCode == 404) {
    final _message = json.decode(response.body)['message'];
    throw ServerException()..message = _message;
  } else {
    throw ServerException();
  }
}
