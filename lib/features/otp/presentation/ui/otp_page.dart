import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/core/navigation.dart';
import 'package:city_flower/core/network/vo/status.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:city_flower/features/register/presentation/ui/register_page.dart';
import 'package:city_flower/injection_container.dart';
import 'package:city_flower/support_ui/support_ui_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../../../../support_ui/button.dart';

class OTPPage extends StatelessWidget {
  final String phoneNumber;
  final REQUEST_TYPE requestType;

  const OTPPage(
      {Key key, @required this.phoneNumber, @required this.requestType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('OTP'),
        ),
        body: _OTPPageBody(
          email: phoneNumber,
          requestType: requestType,
        ),
      ),
    );
  }
}

class _OTPPageBody extends StatefulWidget {
  final String email;
  final REQUEST_TYPE requestType;

  const _OTPPageBody(
      {Key key, @required this.email, @required this.requestType})
      : super(key: key);

  @override
  State<_OTPPageBody> createState() => _OTPPageBodyState();
}

class _OTPPageBodyState extends State<_OTPPageBody> {
  TextEditingController _pinController;

  @override
  void initState() {
    _pinController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state.otpVerificationResource != null) {
          if (state.otpVerificationResource.status == STATUS.error) {
            showSnackBarMessage(
                context, state.otpVerificationResource.failure.message);
          } else if (state.otpVerificationResource.status == STATUS.success) {
            navToSetPasswordPage(
                context: context,
                requestType: widget.requestType,
                token: (state.otpVerificationResource.data as UserVerificationResponse).token,
                verificationResponse: state.otpVerificationResource.data);
          }
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
              ),
              HeadingLarge('Enter OTP sent to ${widget.email}'),
              SizedBox(
                height: 20,
              ),
              PinInputTextFormField(
                controller: _pinController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.go,
                autoFocus: true,
              ),
              SizedBox(
                height: 40,
              ),
              BlocBuilder<OtpBloc, OtpState>(
                builder: (context, state) {
                  if (state.otpVerificationResource != null) {
                    if (state.otpVerificationResource.status ==
                        STATUS.loading) {
                      return circularProgressIndicator();
                    }
                  }
                  return Button(
                    text: 'Verify',
                    fullSized: true,
                    onPressed: () {
                      BlocProvider.of<OtpBloc>(context).add(VerifyOtpEvent(
                          email: widget.email, otp: _pinController.text));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
  }
}
