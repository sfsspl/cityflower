part of 'points_history_bloc.dart';

abstract class PointsHistoryEvent extends Equatable {
  const PointsHistoryEvent();
}

class GetPointsHistoryEvent extends PointsHistoryEvent {


  @override
  List<Object> get props => [];
}
