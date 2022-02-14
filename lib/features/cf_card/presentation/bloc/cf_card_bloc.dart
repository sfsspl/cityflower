import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/vo/resource.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/user/domain/usecase/get_mycf_card_details.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cf_card_event.dart';

part 'cf_card_state.dart';

class CfCardBloc extends Bloc<CfCardEvent, CfCardState> {
  final GetMyCfCardDetails getMyCfCardDetails;

  CfCardBloc({@required this.getMyCfCardDetails})
      : super(CfCardState.initial());

  @override
  Stream<CfCardState> mapEventToState(
    CfCardEvent event,
  ) async* {
    if (event is LoadCfCardPageEvent) {
      yield state.copy(cfCardResource: Resource.loading());

      final _result = await getMyCfCardDetails(NoParams());

      yield* _result.fold((l) async* {
        yield state.copy(cfCardResource: Resource.error(failure: l));
      }, (r) async* {
        yield state.copy(cfCardResource: Resource.success(data: r));
      });
    }
  }
}
