import 'package:bestbuy/presentation/Screen/Customer_Call_List_All/CustomerCallListAllScreen.dart';
import 'package:bestbuy/presentation/Screen/homepage/newcall.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/themes/theme.dart';
import 'package:bestbuy/presentation/widget/extentions.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';



class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = false;
   int _selectedIndex=1;
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

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color:Colors.transparent,
          //boxShadow: AppTheme.shadow),
      ),child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _title() {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical:  0,horizontal: 10),
        color: Colors.white,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            _icon(Icons.sort, color: Colors.black54),
            Image.asset(
              "assets/images/logo2.png",
                //width: double.infinity,
              height: size.height * 0.1,
           ),
            _icon(Icons.account_box, color: Colors.black54),
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

  void onBottomIconPressed(int index) {
    if (index == 0 || index == 1) {
      setState(() {
        isHomePageSelected = true;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
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
//                    Divider(
//                      color: Color(0xffeeeeee),
//                      height: 30,
//                      thickness: 2,
//                      indent: 50,
//                      endIndent: 50,
//                    ),
//                Container(
//                    decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(blurRadius: 8.0),
////                        BoxShadow(color: Colors.white, offset: Offset(-1, 0)),
////                        BoxShadow(color: Colors.white, offset: Offset(1, 0)),
////                        BoxShadow(color: Colors.white, offset: Offset(-1, -1)),
//                        BoxShadow(color: Colors.white, offset: Offset(MediaQuery.of(context).size.width*-1, MediaQuery.of(context).size.width)),
//                      ],
//                    ),
//                  child:
//                     new SizedBox(
//                      height: (MediaQuery.of(context).size.width * 600)/1000,
//
//                      child:   new Swiper(
//                      itemBuilder: (BuildContext context,int index) {
//                        return new Image.asset(
//                          images[index],
////              width: double.infinity,
//                        fit: BoxFit.fill,
//                         // height: MediaQuery.of(context).size.height * 0.2,
//                        );
//                      },
//                      itemCount: images.length,
//                      itemWidth: MediaQuery.of(context).size.width,
//                     // containerHeight:MediaQuery.of(context).size.height *0.3 ,
//                      layout: SwiperLayout.STACK,
//                    ),
//
//                     )),
                    Divider(
                      color: Color(0xffefefef),
                      height: 10,
                      thickness: 0,
                      indent: 100,
                      endIndent: 100,
                    ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: isHomePageSelected
                            ? NewCall(
                                title: "ModChi",
                              )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: CustomerCallListAllScreen(),
                              ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child:
              BottomNavyBar(
                selectedIndex: _selectedIndex,
                showElevation: true, // use this to remove appBar's elevation
                onItemSelected: (index) => setState(() {
                  _selectedIndex = index;
               //   _pageController.animateToPage(index,
               //       duration: Duration(milliseconds: 300), curve: Curves.ease);
                }),
                items: [
                  BottomNavyBarItem(
                    icon: Icon(Icons.apps),
                    title: Text('Home'),
                    activeColor: Colors.red,
                  ),
                  BottomNavyBarItem(
                      icon: Icon(Icons.people),
                      title: Text('Users'),
                      activeColor: Colors.purpleAccent
                  ),
                  BottomNavyBarItem(
                      icon: Icon(Icons.message),
                      title: Text('Messages'),
                      activeColor: Colors.pink
                  ),
                  BottomNavyBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Settings'),
                      activeColor: Colors.blue
                  ),
                ],
              )
//              CustomBottomNavigationBar(
//                onIconPresedCallback: onBottomIconPressed,
//              ),
            )
          ],
        ),
      ),
    );
  }
}
