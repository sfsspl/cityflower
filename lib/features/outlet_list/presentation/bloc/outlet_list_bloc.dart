import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/vo/resource.dart';
import 'package:city_flower/features/outlet_list/domain/entity/outlet_list_entity.dart';
import 'package:city_flower/features/outlet_list/domain/usecase/get_outlet_list_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'outlet_list_event.dart';

part 'outlet_list_state.dart';

class OutletListBloc extends Bloc<OutletListEvent, OutletListState> {
  final GetOutletListUseCase getOutletListUseCase;
  String selectedCity;
  Set<String> cityList = Set();
  List<OutletListEntity> _allOutlets;

  OutletListBloc({@required this.getOutletListUseCase})
      : super(OutletListState.initial());

  @override
  Stream<OutletListState> mapEventToState(
    OutletListEvent event,
  ) async* {
    if (event is GetOutletListEvent) {
      yield state.copy(
          outletList: Resource.loading(), cityList: Resource.loading());
      final _result = await getOutletListUseCase(CountryListSearchParams(
          countryId: event.countryId, city: event.city));
      yield* _result.fold((l) async* {
        yield state.copy(outletList: Resource.error(failure: l));
      }, (r) async* {
        _allOutlets = r;
        if (r.isNotEmpty) {
          r.forEach((element) {
            cityList.add(element.city);
          });
          final sortedCity = SplayTreeSet.from(
            cityList,
            (String a, String b) => a.compareTo(b),
          ).toSet();
          cityList.clear();
          cityList.add("All cities");
          cityList.addAll(sortedCity);
        }
        yield state.copy(
            outletList: Resource.success(data: _allOutlets),
            cityList: Resource.success(data: cityList),
            selectedCity: cityList.first);
      });
    }

    if (event is SelectCityEvent) {
      List<OutletListEntity> _outlets = _allOutlets;

      List<OutletListEntity> _filteredList = event.city.toLowerCase() ==
              'all cities'
          ? _allOutlets
          : _outlets.where((element) {
              return event.city.toLowerCase() == (element).city.toLowerCase();
            }).toList();

      yield state.copy(
          outletList: Resource.success(data: _filteredList ?? _allOutlets),
          selectedCity: event.city);
    }
  }
}
