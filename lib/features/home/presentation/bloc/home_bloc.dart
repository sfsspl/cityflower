import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/vo/resource.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/home/domain/usecase/get_home_banners_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/get_mycf_card_details.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomePageState> {
  final GetHomeBannerUsecase getBannerUsecase;
  final GetMyCfCardDetails getMyCfCardDetails;

  HomeBloc({@required this.getBannerUsecase, @required this.getMyCfCardDetails})
      : super(HomePageState.initial());

  @override
  Stream<HomePageState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadHomePage) {
      yield state.copy(bannerResource: Resource.loading());
      final _bannerRequest = getBannerUsecase(NoParams());
      final _cfCardRequired = getMyCfCardDetails(NoParams());
      final _bannerResponse = await _bannerRequest;
      final _cfCardResponse = await _cfCardRequired;

      yield* _bannerResponse.fold((l) async* {
        print('error $l');
        yield state.copy(bannerResource: Resource.error(failure: l));
      }, (r) async* {
        print('success $r');
        yield state.copy(bannerResource: Resource.success(data: r));
      });

      yield* _cfCardResponse.fold((l) async* {
        print('error $l');
        yield state.copy(myCfCardResource: Resource.error(failure: l));
      }, (r) async* {
        print('success $r');
        yield state.copy(myCfCardResource: Resource.success(data: r));
      });
    }
  }
}
