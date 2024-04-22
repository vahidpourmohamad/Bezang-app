import 'dart:math';
import 'package:bestbuy/Data/dataprovider/UserDataLogic.dart';
import 'package:bestbuy/Data/model/UserDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/User_Rating%20_group/UserRatingGroupScreen.dart';
import 'package:bestbuy/presentation/Screen/User_Rating/UserRatingScreen.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/widget/UsersCard.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String managerName = "";
  List<Color> randomColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.pinkAccent,
    Colors.yellow,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurpleAccent,
    Colors.limeAccent
  ];

  _BodyState() {
    getManagerName(UserLoginDetail.userId).then((val) => setState(() {
          managerName = val;
        }));
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    setState(() {});
    _refreshController.loadComplete();
  }

  Future<String> getManagerName(String id) async {
    UserDataModel temp =
        await UserDataLogic.readOneUserById(UserLoginDetail.userId);
    return temp.name;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserDataModel>>(
        future: UserDataLogic.readUsersGroupByUserId(UserLoginDetail.userId),
        builder: (context, AsyncSnapshot<List<UserDataModel>> snapshot) {
          if (snapshot.hasData) {
            //Size size = MediaQuery.of(context).size;

            return Background(
                child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 10.0,
                        )
                      ]),
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 20, left: 20, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                managerName,
                                // Jalali.now().year.toString()+"/"+Jalali.now().month.toString()+"/"+Jalali.now().day.toString()+"امروز ",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'iransans'),
                              ),
                              Text(
                                "گروه کاری شما",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'iransans'),
                              ),
//                              Text(
//                                "مشتریان شما",
//                                style: TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 16,
//                                    fontFamily: 'iransans'),
//                              ),
                            ]),
                      ))),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(waterDropColor: Colors.blue),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.grey,
                    ),
                    itemBuilder: (context, index) {
                      return UsersCard(
                        prefixBadge: randomColors[Random().nextInt(9)],
                        suffixBadge: randomColors[Random().nextInt(9)],
                        date: snapshot.data![index].telephone.toPersianDigit(),
                        iconColor: Colors.transparent,
                        title: snapshot.data![index].name,
                        suffixIconColor: Colors.transparent,
                        press: () {
                          bool managerPermit = false;
                          if (snapshot.data![index].mangerId ==
                              UserLoginDetail.userId) {
                            managerPermit = true;
                          }
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserRatingGroupScreen(
                              name: snapshot.data![index].name,
                              id: UserLoginDetail.userName,
                              managerPermit: managerPermit,
                            );
                          }));
                        },
//},
                        backgroundColor: Colors.white,
                        descriptionColor: Colors.black,

                        titleColor: Colors.black,
                        profileImage: "https://api.multiavatar.com/" +
                            snapshot.data![index].profilePhoto,
                      );
                    },
                  ),
                ),
                // The ListView
              )
            ]));
          } else {
            if (snapshot.hasError) {
              print("ERROR  " + snapshot.error.toString());
            }
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: LightColor.kPrimaryColor,
                  strokeWidth: 15,
                ));
          }
        });
  }
}
