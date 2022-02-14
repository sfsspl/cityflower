import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/features/points_history/domain/entity/points_history_entity.dart';
import 'package:city_flower/features/points_history/domain/usecase/get_points_history_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'points_history_event.dart';

part 'points_history_state.dart';

class PointsHistoryBloc extends Bloc<PointsHistoryEvent, PointsHistoryState> {
  final GetPointsHistoryUseCase getPointsHistoryUseCase;

  PointsHistoryBloc({@required this.getPointsHistoryUseCase})
      : super(PointsHistoryInitial());

  @override
  Stream<PointsHistoryState> mapEventToState(
    PointsHistoryEvent event,
  ) async* {
    if (event is GetPointsHistoryEvent) {
      yield PointsHistoryLoadingState();
      var _result = await getPointsHistoryUseCase(999999);
      yield* _result.fold((l) async* {
        yield PointsHistoryLoadingFailedState(failure: l);
      }, (r) async* {
        yield PointsHistoryLoadedState(pointsHistory: r);
      });
    }
  }
}
