part of 'home_bloc.dart';

class HomePageState extends Equatable {
  final Resource bannerResource;
  final Resource myCfCardResource;

  HomePageState({this.bannerResource, this.myCfCardResource});

  @override
  List<Object> get props => [bannerResource,myCfCardResource];

  HomePageState copy({Resource bannerResource, Resource myCfCardResource}) {
    return HomePageState(
        bannerResource: bannerResource ?? this.bannerResource,
        myCfCardResource: myCfCardResource ?? this.myCfCardResource);
  }

  factory HomePageState.initial() {
    return HomePageState(
        bannerResource: Resource.loading(),
        myCfCardResource: Resource.loading());
  }
}
