import 'package:city_flower/features/promotion/data/model/promotion_data_model.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:meta/meta.dart';

abstract class PromotionsDataSource {
  Future<List<PromotionDataModel>> getPromotions(
      {@required PROMOTION_TYPE type,@required String token});
}
