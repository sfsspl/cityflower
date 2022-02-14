part of 'cf_card_bloc.dart';

abstract class CfCardEvent extends Equatable {
  const CfCardEvent();
}

class LoadCfCardPageEvent extends CfCardEvent {
  @override
  List<Object> get props => [];
}
