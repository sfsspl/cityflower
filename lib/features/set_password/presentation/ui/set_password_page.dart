import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/core/navigation.dart';
import 'package:city_flower/features/otp/data/model/otp_response.dart';
import 'package:city_flower/features/register/presentation/ui/register_page.dart';
import 'package:city_flower/features/set_password/presentation/bloc/set_password_bloc.dart';
import 'package:city_flower/injection_container.dart';
import 'package:city_flower/support_ui/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class SetPasswordPage extends StatelessWidget {
  final REQUEST_TYPE requestType;
  final String token;
  UserVerificationResponse verificationResponse;

  SetPasswordPage(
      {Key key,
      @required this.requestType,
      this.token,
      this.verificationResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('verification${this.verificationResponse}');
    return BlocProvider<SetPasswordBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Set new password'),
        ),
        body: _SetPasswordPageBody(
          requestType: requestType,
          verificationResponse: verificationResponse,
          token: token,
        ),
      ),
    );
  }
}

class _SetPasswordPageBody extends StatefulWidget {
  final REQUEST_TYPE requestType;
  final String token;
  UserVerificationResponse verificationResponse;

  _SetPasswordPageBody(
      {Key key,
      @required this.requestType,
      @required this.token,
      this.verificationResponse})
      : super(key: key);

  @override
  State<_SetPasswordPageBody> createState() => _SetPasswordPageBodyState();
}

class _SetPasswordPageBodyState extends State<_SetPasswordPageBody> {
  TextEditingController _passwordController, _cPasswordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _cPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetPasswordBloc, SetPasswordState>(
      listener: (context, state) {
        if (state is SetPasswordFailed) {
          showSnackBarMessage(context, state.failure.message);
        } else if (state is SetPasswordSuccessful) {
          navToHome(context, launchMode: LAUNCH_MODE.SINGLE_TOP);
        }
      },
      child: BlocBuilder<SetPasswordBloc, SetPasswordState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Image.asset('assets/logo/logo.png'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder()),
                    validator: (text) {
                      if (text.isEmpty) {
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _cPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder()),
                    validator: (text) {
                      if (text.isEmpty) {
                        return 'Re enter password';
                      } else if (_passwordController.text !=
                          _cPasswordController.text) {
                        return 'Confirm password does not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<SetPasswordBloc, SetPasswordState>(
                    builder: (context, state) {
                      if (state is SetPasswordStarted) {
                        return circularProgressIndicator();
                      }
                      return Button(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            BlocProvider.of<SetPasswordBloc>(context).add(
                              SetNewPasswordEvent(
                                  password: _passwordController.text,
                                  requestType: widget.requestType,
                                  userVerificationResponse:
                                      widget.verificationResponse,
                                  token: widget.token),
                            );
                          }
                        },
                        text: 'Continue',
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _cPasswordController.dispose();
  }
}
