import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../const_variables.dart';

Future<http.Response> httpPostRequest(
    {@required http.Client httpClient,
    @required String url,
    Map<String, String> params,
    String token = ''}) async {
  try {
    return await httpClient.post(
      Uri.parse(url),
      body: json.encode(params),
      headers: {
        'Content-type': 'application/json',
        AUTHORIZATION: BEARER + " " + token
      },
    );
  } catch (ex) {
    return http.Response("", 500);
  }
}

Future<http.Response> httpGetRequest(
    {@required http.Client httpClient,
    @required String url,
    String token = '',
    Map<String, String> params}) async {
  try {
    Uri uri = Uri.parse(url);
    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }
    return await httpClient.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        AUTHORIZATION: BEARER + " " + token
      },
    );
  } catch (ex) {
    return http.Response("", 500);
  }
}
