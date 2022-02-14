part of 'promotion_bloc.dart';

abstract class PromotionEvent extends Equatable {
  const PromotionEvent();
}

class LoadPromotionsEvent extends PromotionEvent {
  final PROMOTION_TYPE type;

  LoadPromotionsEvent({@required this.type});

  @override
  List<Object> get props => [type];
}

