part of 'user_bloc.dart';

class UserState extends Equatable {
  final Resource userDetails;
  final Resource logoutState;

  UserState({this.userDetails, this.logoutState});

  @override
  List<Object> get props => [userDetails, logoutState];

  factory UserState.initial() {
    return UserState(userDetails: Resource.loading());
  }

  UserState copy({Resource userDetails, Resource logoutState}) {
    return UserState(
        userDetails: userDetails ?? this.userDetails,
        logoutState: logoutState ?? this.logoutState);
  }
}
