import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/core/navigation.dart';
import 'package:city_flower/core/network/vo/status.dart';
import 'package:city_flower/features/login/presentation/bloc/login_bloc.dart';
import 'package:city_flower/features/register/presentation/ui/register_page.dart';
import 'package:city_flower/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../support_ui/button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: _LoginPageBody(),
      ),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  @override
  __LoginPageBodyState createState() => __LoginPageBodyState();
}

class __LoginPageBodyState extends State<_LoginPageBody> {
  TextEditingController _numberController, _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _numberController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (_, state) {
        return state.login != null ||
            (state.login.status != state.login.status);
      },
      listener: (context, state) {
        if (state.login.status == STATUS.error) {
          showSnackBarMessage(context, state.login.failure.message);
        } else if (state.login.status == STATUS.success) {
          showToastMessage(context, state.login.data);
          navToOTPPage(context: context, phoneNumber: _numberController.text);
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
              Image.asset('assets/logo/logo.png'),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  enabledBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                ),
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    navToRegister(context, REQUEST_TYPE.FORGOT_PASSWORD);
                  },
                  child: Text('Forgot Password?'),
                ),
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.login != null) {
                    if (state.login.status == STATUS.loading) {
                      return circularProgressIndicator();
                    }
                  }
                  return Button(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginEvent(
                              phoneNumber: _numberController.text,
                              password: _passwordController.text),
                        );
                      }
                    },
                    text: 'Login',
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                onPressed: () {
                  navToRegister(context, REQUEST_TYPE.SIGN_IN);
                },
                text: 'Register',
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
    _passwordController.dispose();
  }
}
