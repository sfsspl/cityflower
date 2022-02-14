part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final Resource firstLaunch;
  final Resource loggedIn;

  SplashState({this.firstLaunch, this.loggedIn});

  @override
  List<Object> get props => [firstLaunch, loggedIn];

  SplashState copy({Resource firstLaunch, Resource loggedIn}) {
    return SplashState(
        firstLaunch: firstLaunch ?? this.firstLaunch,
        loggedIn: loggedIn ?? this.loggedIn);
  }
}
