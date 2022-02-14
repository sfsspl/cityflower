part of 'outlet_list_bloc.dart';

abstract class OutletListEvent extends Equatable {
}

class GetOutletListEvent extends OutletListEvent {
  final int countryId;
  final String city;

  GetOutletListEvent({this.countryId, this.city});
  @override
  List<Object> get props => [countryId,city];
}

class SelectCityEvent extends OutletListEvent{
  final String city;

  SelectCityEvent({@required this.city});
  @override
  List<Object> get props => [city];
}