part of 'points_history_bloc.dart';

abstract class PointsHistoryState extends Equatable {
  const PointsHistoryState();
}

class PointsHistoryInitial extends PointsHistoryState {
  @override
  List<Object> get props => [];
}

class PointsHistoryLoadingState extends PointsHistoryState {
  @override
  List<Object> get props => [];
}

class PointsHistoryLoadingFailedState extends PointsHistoryState {
  final Failure failure;

  PointsHistoryLoadingFailedState({@required this.failure});

  @override
  List<Object> get props => [failure];
}

class PointsHistoryLoadedState extends PointsHistoryState {
  final List<PointsHistoryEntity> pointsHistory;

  PointsHistoryLoadedState({@required this.pointsHistory});

  @override
  List<Object> get props => [pointsHistory];
}
