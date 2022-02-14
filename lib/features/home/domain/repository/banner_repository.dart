import 'package:city_flower/core/network/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<String>>> getBanners();
}
