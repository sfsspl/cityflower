part of 'cf_card_bloc.dart';

class CfCardState extends Equatable {
  final Resource cfCardResource;

  CfCardState({this.cfCardResource});

  factory CfCardState.initial() {
    return CfCardState(cfCardResource: Resource.loading());
  }

  @override
  List<Object> get props => [cfCardResource];

  CfCardState copy({Resource cfCardResource}) {
    return CfCardState(cfCardResource: cfCardResource ?? this.cfCardResource);
  }
}
