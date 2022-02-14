import 'dart:convert';

import 'package:city_flower/core/network/api_endpoints.dart';
import 'package:city_flower/core/network/http_call.dart';
import 'package:city_flower/core/network/http_error_handler.dart';
import 'package:city_flower/features/promotion/data/datasource/promotion_data_source.dart';
import 'package:city_flower/features/promotion/data/model/promotion_data_model.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class PromotionsDataSourceImpl implements PromotionsDataSource {
  final http.Client httpClient;

  PromotionsDataSourceImpl({@required this.httpClient});

  @override
  Future<List<PromotionDataModel>> getPromotions(
      {PROMOTION_TYPE type, String token}) async {
    final _params = {
      'special_promotion': type == PROMOTION_TYPE.normal ? '0' : '1'
    };
    print('params $_params');
    var response = await httpGetRequest(
        httpClient: httpClient,
        url: PROMOTIONS_API_ENDPOINT,
        token: token,
        params: _params);

    if (response.statusCode == 200) {
      List<dynamic> _responseJson = json.decode(response.body)['promotions'];
      List<PromotionDataModel> _promotions = _responseJson
          .map((e) => PromotionDataModel.fromJson(e))
          .toList()
          .cast();
      return _promotions;
    }
    handleError(response);
  }
}
