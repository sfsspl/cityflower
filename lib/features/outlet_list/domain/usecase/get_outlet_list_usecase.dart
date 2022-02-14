import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/outlet_list/domain/entity/outlet_list_entity.dart';
import 'package:city_flower/features/outlet_list/domain/repository/outlet_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetOutletListUseCase
    extends UseCase<List<OutletListEntity>, CountryListSearchParams> {
  final OutletRepository outletRepository;

  GetOutletListUseCase({@required this.outletRepository});

  @override
  Future<Either<Failure, List<OutletListEntity>>> call(
      CountryListSearchParams params) async {
    return await outletRepository.getOutletList(
        countryId: params.countryId, city: params.city);
  }
}

class CountryListSearchParams {
  final int countryId;
  final String city;

  CountryListSearchParams({this.countryId, this.city});
}
