part of 'outlet_list_bloc.dart';

class OutletListState extends Equatable {
  final Resource outletList, cityList;
  String selectedCity;

  OutletListState({this.outletList, this.cityList, this.selectedCity});

  @override
  List<Object> get props => [outletList, cityList, selectedCity];

  factory OutletListState.initial() {
    return OutletListState(
        outletList: Resource.loading(), cityList: Resource.loading());
  }

  OutletListState copy(
      {Resource outletList, Resource cityList, String selectedCity}) {
    return OutletListState(
        outletList: outletList ?? this.outletList,
        cityList: cityList ?? this.cityList,
        selectedCity: selectedCity ?? this.selectedCity);
  }
}
