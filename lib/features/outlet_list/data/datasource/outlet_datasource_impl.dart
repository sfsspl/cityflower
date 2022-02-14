import 'dart:convert';

import 'package:city_flower/core/network/api_endpoints.dart';
import 'package:city_flower/core/network/http_call.dart';
import 'package:city_flower/core/network/http_error_handler.dart';
import 'package:city_flower/features/outlet_list/data/datasource/outlet_datasource.dart';
import 'package:city_flower/features/outlet_list/data/model/outlet_list_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class OutletDataSourceImpl implements OutletDataSource {
  final http.Client client;

  OutletDataSourceImpl({@required this.client});

  @override
  Future<List<OutletListDataModel>> getOutletList(
      {String token, int countryId, String city}) async {
    var _response = await httpGetRequest(
        httpClient: client,
        url: OUTLET_LIST_API_ENDPOINT,
        token: token,);

    if (_response.statusCode == 200) {
      List<dynamic> _responseJson = json.decode(_response.body)['outlets'];
      List<OutletListDataModel> _outlets = _responseJson
          .map((e) => OutletListDataModel.fromJson(e))
          .toList()
          .cast();
      return _outlets;
    }
    handleError(_response);
  }
}
