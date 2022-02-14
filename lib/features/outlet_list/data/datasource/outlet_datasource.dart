import 'package:city_flower/features/outlet_list/data/model/outlet_list_data_model.dart';
import 'package:meta/meta.dart';
abstract class OutletDataSource{
  Future<List<OutletListDataModel>> getOutletList({@required String token,int countryId, String city});
}