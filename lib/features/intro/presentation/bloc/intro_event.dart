part of 'intro_bloc.dart';

abstract class IntroEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetFirstLaunchCompleteEvent extends IntroEvent{}