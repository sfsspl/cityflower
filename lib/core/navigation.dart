import 'package:city_flower/features/cf_card/presentation/ui/cf_card_page.dart';
import 'package:city_flower/features/home/presentation/ui/home_page.dart';
import 'package:city_flower/features/intro/presentation/ui/intro_page.dart';
import 'package:city_flower/features/login/presentation/ui/login_page.dart';
import 'package:city_flower/features/otp/presentation/ui/otp_page.dart';
import 'package:city_flower/features/outlet_list/presentation/ui/outlet_list_page.dart';
import 'package:city_flower/features/points_history/presentation/ui/points_history_page.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:city_flower/features/promotion/presentation/ui/promotion_page.dart';
import 'package:city_flower/features/register/presentation/ui/register_page.dart';
import 'package:flutter/material.dart';

enum LAUNCH_MODE { SINGLE_TOP, REPLACEMENT, LAUNCH }

void navToHome(BuildContext context, {LAUNCH_MODE launchMode}) {
  _navigate(context, HomePage(), launchMode: launchMode);
}

void navToLogin(context, {LAUNCH_MODE launchMode = LAUNCH_MODE.REPLACEMENT}) {
  _navigate(context, LoginPage(), launchMode: launchMode);
}

void navToIntro(context) {
  _navigate(context, IntroPage(), launchMode: LAUNCH_MODE.REPLACEMENT);
}

void navToPromotions(context, {@required promotionType: PROMOTION_TYPE}) {
  _navigate(
      context,
      PromotionPage(
        type: promotionType,
      ));
}

void navToRegister(context, REQUEST_TYPE request_type) {
  _navigate(context, RegisterPage(requestType: request_type));
}

void navToOTPPage({@required context, @required String phoneNumber}) {
  _navigate(
    context,
    OTPPage(
      phoneNumber: phoneNumber,
    ),
  );
}

void navToMyCFCard({@required BuildContext context}) {
  _navigate(context, CFCardPage());
}

void navToOutletList({@required BuildContext context}) {
  _navigate(context, OutletListPage());
}

void navToPointsHistory(@required BuildContext context) {
  _navigate(context, PointsHistoryPage());
}

void _navigate(BuildContext context, Widget page, {LAUNCH_MODE launchMode}) {
  if (launchMode == LAUNCH_MODE.REPLACEMENT) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  } else if (launchMode == LAUNCH_MODE.SINGLE_TOP) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  } else {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}
