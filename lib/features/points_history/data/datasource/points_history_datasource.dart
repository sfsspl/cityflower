import 'package:city_flower/features/points_history/data/model/point_history_model.dart';
import 'package:meta/meta.dart';

abstract class PointsHistoryDataSource {
  Future<List<PointsHistoryModel>> getPointsHistory(
      {@required String token, @required int itemsPerPage});
}
