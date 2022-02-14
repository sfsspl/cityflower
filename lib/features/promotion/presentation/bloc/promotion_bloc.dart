import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:city_flower/features/promotion/domain/usecase/get_promotions.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'promotion_event.dart';

part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final GetPromotionUseCase promotionUseCase;

  PromotionBloc({@required this.promotionUseCase}) : super(PromotionInitial());

  @override
  Stream<PromotionState> mapEventToState(
    PromotionEvent event,
  ) async* {
    if (event is LoadPromotionsEvent) {
      yield PromotionLoadingState();
      final _result = await promotionUseCase(event.type);
      yield* _result.fold((l) async* {
        yield PromotionsLoadFailedState(message: l.message);
      }, (r) async* {
        yield PromotionLoadedState(promotions: r);
      });
    }
  }
}
