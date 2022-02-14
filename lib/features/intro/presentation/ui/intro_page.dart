import 'package:city_flower/core/navigation.dart';
import 'package:city_flower/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:city_flower/injection_container.dart';
import 'package:city_flower/support_ui/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntroBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _IntroPageBody(),
      ),
    );
  }
}

class _IntroPageBody extends StatefulWidget {
  @override
  State<_IntroPageBody> createState() => _IntroPageBodyState();
}

class _IntroPageBodyState extends State<_IntroPageBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<IntroBloc>(context).add(SetFirstLaunchCompleteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Image.asset('assets/logo/logo.png'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                'Hello..\n'
                'We are super excited to serve you smartly..\n'
                'Welcome to mycf',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 42,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Button(
            text: 'Continue',
            onPressed: () {
              navToLogin(context);
            },
          ),
        )
      ],
    );
  }
}
