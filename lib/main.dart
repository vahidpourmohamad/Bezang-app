import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/homepage/mainPage.dart';
import 'package:bestbuy/presentation/Screen/introduction/introduction_screen.dart';

import 'package:flutter/material.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'constant/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pushe_flutter/pushe.dart';

void main() {
  runApp(BezangApp());
}

class BezangApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _BezangApp createState() => _BezangApp();
}

class _BezangApp extends State<BezangApp> {
  bool isLoaded = false;

  @override
  void initState() {
    final eventName = "Open Application";
    Pushe.sendEvent(eventName);
    settingLoad();
    super.initState();
  }

  settingLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLoginDetail.userId = (prefs.getString('userId') ?? "");
    UserLoginDetail.mobile = (prefs.getString('mobile') ?? "");
    UserLoginDetail.userName = (prefs.getString('userName') ?? "");
    //UserLoginDetail.version = (prefs.getString('version') ?? "");
    UserLoginDetail.introduction = (prefs.getBool("introduction") ?? false);
    UserLoginDetail.profilePhoto=(prefs.getString('profilePhoto') ?? "");
    UserLoginDetail.paymentStatus=(prefs.getBool('paymentStatus') ??false);
    setState(() => isLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? CircularProgressIndicator()
        : MaterialApp(
            builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget!),
                maxWidth: 1200,
                minWidth: 450,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(450, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(color: Color(0xFFF5F5F5))),
            debugShowCheckedModeBanner: false,
            title: 'بفروش',
            theme: ThemeData(
                primaryColor: kPrimaryColor,
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'iransans'),
            home: UserLoginDetail.introduction
                ? MainPage(
                    title: 'Call Sale',
                  )
                : IntroductionScreenWidget(),
          );
  }
}
