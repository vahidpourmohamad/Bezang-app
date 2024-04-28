import 'package:bestbuy/Data/dataprovider/DataProviderConfig.dart';
import 'package:bestbuy/Data/dataprovider/UserDataLogic.dart';
import 'package:bestbuy/Data/model/UserDataModel.dart';
import 'package:bestbuy/presentation/Screen/Setting/settingscreen.dart';
import 'package:bestbuy/presentation/Screen/about/about_screen.dart';

import 'package:bestbuy/presentation/Screen/introduction/introduction_screen.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:bestbuy/presentation/widget/avatarNetworkUnique.dart';
import 'package:dio/dio.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/config/setting.dart';
import 'package:bestbuy/presentation/Screen/Customer_Call_List/CustomerCallListScreen.dart';
import 'package:bestbuy/presentation/Screen/Customer_Call_List_All/CustomerCallListAllScreen.dart';
import 'package:bestbuy/presentation/Screen/UserGroup/UserGroupListScreen.dart';
import 'package:bestbuy/presentation/Screen/User_Rating/UserRatingScreen.dart';
import 'package:bestbuy/presentation/Screen/homepage/newcall.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/themes/theme.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pushe_flutter/pushe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = false;

  //int _selectedIndex = 1;
  int _currentIndex = 2;
  PageController _pageController = PageController(initialPage: 2);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    super.initState();
    //_pageController = PageController();
    if (UserLoginDetail.introduction == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return IntroductionScreenWidget();
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
//          RotatedBox(
//            quarterTurns: 4,
//            child: _icon(Icons.sort, color: Colors.black54),
//          ),
//          ClipRRect(
//            borderRadius: BorderRadius.all(Radius.circular(13)),
//            child: Container(
//              decoration: BoxDecoration(
//                color: Theme.of(context).backgroundColor,
//                boxShadow: <BoxShadow>[
//                  BoxShadow(
//                      color: Color(0xfff8f8f8),
//                      blurRadius: 10,
//                      spreadRadius: 10),
//                ],
//              ),
//              child: Image.asset("assets/images/user.png"),
//            ),
//          ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );
  }

/*
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: Colors.transparent,
        //boxShadow: AppTheme.shadow),
      ),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }
*/
  Widget _title() {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        color: Colors.white,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            IconButton(
              icon: new Icon(Icons.sort),
              highlightColor: Colors.grey,
              onPressed: () => _key.currentState!.openDrawer(),
            ),
            Image.asset(
              "assets/images/logotop.jpg",
              //width: double.infinity,
              height: size.height * 0.1,
            ),
            AvatarNetworkUnique(userName: UserLoginDetail.userId),

            //Text(
//      "جناب آقای عیدی زاده خوش آمدید",
//      style: TextStyle(
//          fontWeight: FontWeight.bold,
//          fontSize: 10,
//          fontFamily: 'iransans'),
//    ),
          ],
        ));
  }

  versionCheck(BuildContext context) async {
//    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().get(nodeJsUrl + '/version');

    UserDataModel Ut =
        await UserDataLogic.readOneUserById(UserLoginDetail.userId);
    UserLoginDetail.internal = Ut.age.toString();

    print(response.data.runtimeType);
    print(response.data);
    print(UserLoginDetail.version);
    if (response.data != UserLoginDetail.version) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: Text('لطفا برنامه خود را بروزرسانی کنید',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'iransans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              content: RoundedButton(
                  text: "خروج از برنامه",
                  press: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  })));
    }

    //  UserDataModel user=UserDataModel.fromList(response.data,0);
  }

  news(BuildContext context) async {
//    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().get(nodeJsUrl + '/news');
    print(response.data.runtimeType);
    print(response.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = prefs.getString("news") ?? "";
    if (response.data != "" && temp != response.data) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: Text(response.data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'iransans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              content: RoundedButton(
                  text: "باشه",
                  press: () async {
                    prefs.setString("news", response.data);
                    Navigator.pop(context);
                  })));
    }

    //  UserDataModel user=UserDataModel.fromList(response.data,0);
  }

  @override
  Widget build(BuildContext context) {
    Setting.mediaSize = MediaQuery.of(context).size;
    versionCheck(context);
    news(context);
    print(UserLoginDetail.paymentStatus);

    return Scaffold(
      key: _key,
      body: SafeArea(
          child: Stack(fit: StackFit.expand, children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: AppTheme.fullHeight(context) - 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffffffff),
                  Color(0xffffffff),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _appBar(),
                _title(),
                Divider(
                  color: Color(0xffefefef),
                  height: 10,
                  thickness: 0,
                  indent: 100,
                  endIndent: 100,
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    children: <Widget>[
                      // UserLoginDetail.paymentStatus?
                      NewCall(
                        title: "Bezang",
                      ),
//                      :
//                      CustomerAddScreen(),
                      CustomerCallListScreen(),
                      UserRatingScreen(),
                      CustomerCallListAllScreen(),
                      UserGroupScreen()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ])),
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 75,
        selectedIndex: _currentIndex,
        backgroundColor: Colors.white,
        showElevation: true,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('تماس جدید', textAlign: TextAlign.center),
              icon: Icon(Icons.person_add),
              activeColor: LightColor.kPrimaryColor,
              inactiveColor: LightColor.kPrimaryColor),
          BottomNavyBarItem(
              title: Text('تماس امروز', textAlign: TextAlign.center),
              icon: Icon(Icons.call),
              activeColor: LightColor.kPrimaryColor,
              inactiveColor: LightColor.kPrimaryColor),
          BottomNavyBarItem(
              title: Text(
                'امتیازات',
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.star),
              activeColor: LightColor.kPrimaryColor,
              inactiveColor: LightColor.kPrimaryColor),
          BottomNavyBarItem(
              title: Text('مشتریان', textAlign: TextAlign.center),
              icon: Icon(Icons.account_box),
              activeColor: LightColor.kPrimaryColor,
              inactiveColor: LightColor.kPrimaryColor),
          BottomNavyBarItem(
              title: Text('گروه کاری', textAlign: TextAlign.center),
              icon: Icon(Icons.group),
              activeColor: LightColor.kPrimaryColor,
              inactiveColor: LightColor.kPrimaryColor),
        ],
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
        UserAccountsDrawerHeader(
            accountName: Text(UserLoginDetail.userName),
            accountEmail: Text(UserLoginDetail.mobile),
            currentAccountPicture:
                AvatarNetworkUnique(userName: UserLoginDetail.userId),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/accountback.jpg"),
                    fit: BoxFit.cover))),
//        ListTile(
//          title: Text('حساب کاربری'),
//          leading: Icon(Icons.person),
//          onLongPress: () {ScaffoldMessenger.of(context)
//              .showSnackBar(SnackBar(
//            content: Text("هنوز فعال نیست"),
//          ));},
//        ),
//        ListTile(
//          title: Text('تنضیمات'),
//          leading: Icon(Icons.settings),
//          onLongPress: () {ScaffoldMessenger.of(context)
//              .showSnackBar(SnackBar(
//            content: Text("هنوز فعال نیست"),
//          ));},
//        ),AboutScreen
        ListTile(
          title: Text('درباره ما'),
          leading: Icon(Icons.help),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AboutScreen();
                },
              ),
            );
          },
        ),
        ListTile(
          title: Text('تنظیمات'),
          leading: Icon(Icons.settings),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SettingScreen();
                },
              ),
            );
          },
        ),
        ListTile(
          title: Text('خروج از حساب'),
          leading: Icon(Icons.account_box_rounded),
          onTap: () async {
            /*
            This section is for LogOut
             */
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("introduction", false);
            UserLoginDetail.introduction = false;
            UserLoginDetail.userName = ""; // textNameController.text;
            prefs.setString("mobile", "");
            prefs.setString("userName", "");
            prefs.setString("version", "");
            prefs.setString("profilePhoto", "");
            prefs.setString("userId", "");
            Pushe.sendEvent("User_Log_Out");
            ////////
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return IntroductionScreenWidget();
                },
              ),
            );
          },
        ),
        ListTile(
          title: Text('خروج از برنامه'),
          leading: Icon(Icons.exit_to_app),
          onTap: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        ),
        ListTile(
          title: Text(UserLoginDetail.version),
          onTap: () {},
        ),
      ])),
    );
  }
}
