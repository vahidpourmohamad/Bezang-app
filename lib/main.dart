import 'package:bestbuy/Data/dataprovider/UserDataLogic.dart';
import 'package:bestbuy/Data/model/UserDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/homepage/mainPage.dart';
import 'package:bestbuy/presentation/Screen/introduction/introduction_screen.dart';
import 'package:bestbuy/presentation/Screen/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'constant/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
      title: 'بزنگ', debugShowCheckedModeBanner: false, home: BezangApp()));
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
    //final eventName = "Open Application";
    //Pushe.sendEvent(eventName);
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
    UserLoginDetail.profilePhoto = (prefs.getString('profilePhoto') ?? "");
    UserLoginDetail.paymentStatus = (prefs.getBool('paymentStatus') ?? true);
    UserDataModel user =
        await UserDataLogic.readOneUserByMobile(UserLoginDetail.mobile);
    if (user.id != "-1") {
      prefs.setBool("introduction", true);
      prefs.setString("profilePhoto", user.profilePhoto);
      prefs.setBool("paymentStatus", user.paymentStatus);
      UserLoginDetail.introduction = true;
      UserLoginDetail.profilePhoto = user.profilePhoto;
      UserLoginDetail.paymentStatus = user.paymentStatus;
    }

    setState(() => isLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? CircularProgressIndicator()
        : MaterialApp(
            builder: (context, widget) => ResponsiveBreakpoints.builder(
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(
                      start: 1921, end: double.infinity, name: '4K'),
                ],
                child: UserLoginDetail.introduction
                    ? MainPage(
                        title: 'Call Sale',
                      )
                    : IntroductionScreenWidget()),
            debugShowCheckedModeBanner: false,
            title: 'بفروش',
            theme: ThemeData(
                primaryColor: kPrimaryColor,
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'iransans'),
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => MainPage(title: "بفروش"),
              'WellComeScreen': (BuildContext context) =>
                  MainPage(title: "بفروش")
            },
            onUnknownRoute: (settings) => MaterialPageRoute(
                builder: (context) => const SizedBox.shrink()),
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(builder: (context) {
                return BouncingScrollWrapper.builder(
                    context, buildPage(settings.name ?? ''),
                    dragWithMouse: true);
              });
            },
          );
  }

  Widget buildPage(String name) {
    switch (name) {
      case '/':
      case "WellComeScreen":
        return const WelcomeScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
