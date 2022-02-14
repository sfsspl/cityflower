part of 'promotion_bloc.dart';

abstract class PromotionState extends Equatable {
  const PromotionState();
}

class PromotionInitial extends PromotionState {
  @override
  List<Object> get props => [];
}

class PromotionLoadingState extends PromotionState {
  @override
  List<Object> get props => [];
}

class PromotionLoadedState extends PromotionState {
  final List<PromotionEntity> promotions;

  PromotionLoadedState({@required this.promotions});

  @override
  List<Object> get props => [promotions];
}

class PromotionsLoadFailedState extends PromotionState {
  final String message;

  PromotionsLoadFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}
