import 'package:meta/meta.dart';
abstract class BannerDataSource {
  Future<List<String>> getBanners({@required String token});
}
