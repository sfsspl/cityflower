import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/features/outlet_list/domain/entity/outlet_list_entity.dart';
import 'package:dartz/dartz.dart';

abstract class OutletRepository {
  Future<Either<Failure, List<OutletListEntity>>> getOutletList(
      {int countryId, String city});
}
