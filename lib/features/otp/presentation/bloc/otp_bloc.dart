import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_flower/core/network/vo/resource.dart';
import 'package:city_flower/features/otp/domain/repository/otp_repository.dart';
import 'package:city_flower/features/user/domain/usecase/save_user_data_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/save_user_token.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OTPRepository otpRepository;
  final SaveUserDataUseCase saveUserDataUseCase;
  final SaveUserTokenUseCase saveUserTokenUseCase;

  OtpBloc(
      {@required this.otpRepository,
      @required this.saveUserDataUseCase,
      @required this.saveUserTokenUseCase})
      : super(OtpState.initial());

  @override
  Stream<OtpState> mapEventToState(
    OtpEvent event,
  ) async* {
    if (event is VerifyOtpEvent) {
      yield state.copy(otpVerificationResource: Resource.loading());
      final _result = await otpRepository.verifyOTP(
          phoneNumber: event.email, otp: event.otp);

      yield* _result.fold((failure) async* {
        yield state.copy(
            otpVerificationResource: Resource.error(failure: failure));
      }, (otpResponse) async* {
        yield state.copy(
            otpVerificationResource: Resource.success(data: otpResponse));
      });
    }
  }
}
