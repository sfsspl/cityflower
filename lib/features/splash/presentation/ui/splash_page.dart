import 'dart:async';

import 'package:city_flower/core/navigation.dart';
import 'package:city_flower/core/network/vo/status.dart';
import 'package:city_flower/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:city_flower/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => serviceLocator(),
      child: Scaffold(
        body: _SplashPageBody(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _SplashPageBody extends StatefulWidget {
  _SplashPageBody({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<_SplashPageBody> {
  @override
  void initState() {
    _checkFirstLauch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.firstLaunch.status == STATUS.success) {
          if (state.firstLaunch.data as bool) {
            navToIntro(context);
          }
        }
        if (state.loggedIn != null && state.loggedIn.status == STATUS.success) {
          if (state.loggedIn.data as bool) {
            navToHome(context, launchMode: LAUNCH_MODE.SINGLE_TOP);
          } else {
            navToLogin(context);
          }
        }
      },
      child: Center(
        child: Image.asset('assets/logo/logo.png'),
      ),
    );
  }

  void _checkFirstLauch() {
    Timer(
      Duration(seconds: 2),
      () {
        BlocProvider.of<SplashBloc>(context).add(CheckFirstLaunchEvent());
      },
    );
  }
}
