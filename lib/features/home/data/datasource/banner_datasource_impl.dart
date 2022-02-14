import 'dart:convert';

import 'package:city_flower/core/network/api_endpoints.dart';
import 'package:city_flower/core/network/http_call.dart';
import 'package:city_flower/core/network/http_error_handler.dart';
import 'package:city_flower/features/home/data/datasource/banner_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class BannerDataSourceImpl implements BannerDataSource {
  final http.Client httpClient;

  BannerDataSourceImpl({@required this.httpClient});

  @override
  Future<List<String>> getBanners({String token}) async {
    print('token $token');
    var response = await httpGetRequest(
      httpClient: httpClient,
      url: BANNERS_API_ENDPOINT,
      token: token
    );
    if (response.statusCode == 200) {
      List<dynamic> _responseJson =
          json.decode(response.body)['banners'] as List<dynamic>;
      List<String> _images = _responseJson.map((e) => e['image_url']).toList().cast();
      return _images;
    }
    handleError(response);
  }
}
