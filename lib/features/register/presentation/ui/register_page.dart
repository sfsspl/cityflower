import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/core/navigation.dart';
import 'package:city_flower/features/register/presentation/bloc/register_bloc.dart';
import 'package:city_flower/injection_container.dart';
import 'package:city_flower/support_ui/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

enum REQUEST_TYPE { SIGN_IN, FORGOT_PASSWORD, CHANGE_PASSWORD }

class RegisterPage extends StatelessWidget {
  final REQUEST_TYPE requestType;

  const RegisterPage({Key key, @required this.requestType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(requestType == REQUEST_TYPE.SIGN_IN
              ? 'Register'
              : 'Forgot Password'),
        ),
        body: _RegisterPageBody(
          requestType: requestType,
        ),
      ),
    );
  }
}

class _RegisterPageBody extends StatefulWidget {
  final REQUEST_TYPE requestType;

  const _RegisterPageBody({Key key, @required this.requestType})
      : super(key: key);

  @override
  State<_RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<_RegisterPageBody> {
  TextEditingController _numberController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _numberController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegistrationFailedState) {
          showSnackBarMessage(context, state.failure.message);
        }
        if (state is RegistrationSuccessState) {
          navToOTPPage(
              context: context,
              phoneNumber: _numberController.text,
              request_type: REQUEST_TYPE.SIGN_IN);
        }
      },
      child: Form(
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
                controller: _numberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Enter mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterationInitiatedState) {
                    return circularProgressIndicator();
                  }
                  return Button(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        BlocProvider.of<RegisterBloc>(context).add(
                          RegisterEvent(
                              mobileNumber: _numberController.text,
                              isForgotPassword: widget.requestType ==
                                  REQUEST_TYPE.FORGOT_PASSWORD),
                        );
                      }
                    },
                    text: 'Request OTP',
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _numberController.dispose();
  }
}
