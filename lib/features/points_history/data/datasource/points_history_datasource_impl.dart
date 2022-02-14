import 'dart:convert';

import 'package:city_flower/core/network/api_endpoints.dart';
import 'package:city_flower/core/network/http_call.dart';
import 'package:city_flower/core/network/http_error_handler.dart';
import 'package:city_flower/features/points_history/data/datasource/points_history_datasource.dart';
import 'package:city_flower/features/points_history/data/model/point_history_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class PointsHistoryDataSourceImpl implements PointsHistoryDataSource {
  final http.Client httpClient;

  PointsHistoryDataSourceImpl({@required this.httpClient});

  @override
  Future<List<PointsHistoryModel>> getPointsHistory(
      {token, int itemsPerPage}) async {
    var _response = await httpPostRequest(
        httpClient: httpClient,
        url: POINTS_HISTORY_API_ENDPOINT,
        token: token,
        params: {'items_per_page': itemsPerPage.toString()});
    if (_response.statusCode == 200) {
      List<dynamic> _responseJson = json.decode(_response.body)['data'];
      List<PointsHistoryModel> _pointsHistory = _responseJson
          .map((e) => PointsHistoryModel.fromJSON(e))
          .toList()
          .cast();
      return _pointsHistory;
    }
    handleError(_response);
  }
}
