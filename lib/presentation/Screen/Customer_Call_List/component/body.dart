import 'package:bestbuy/Data/dataprovider/CallDataLogic.dart';
import 'package:bestbuy/Data/model/CallDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/Customer_Call/CustomerCallScreen.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/widget/EasyCard.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CallDataModel>>(
        future: CallDataLogic.readEnabledInProgressCallsByUser(
            UserLoginDetail.userId, DateTime.now().toString()),
        builder: (context, AsyncSnapshot<List<CallDataModel>> snapshot) {
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
                            top: 10, bottom: 20, left: 10, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateTime.now()
                                    .toPersianDateStr(showDayStr: true),
                                // Jalali.now().year.toString()+"/"+Jalali.now().month.toString()+"/"+Jalali.now().day.toString()+"امروز ",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'iransans'),
                              ),
                              Text(
                                "لیست تماس های امروز",
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
                      Color cl = Colors.black;
                      String description = "";
                      switch (snapshot.data![index].status) {
                        case "1":
                          {
                            cl = Colors.green;
                            description = "فروش موفق انجام شد";
                          }
                          break;
                        case "2":
                          {
                            cl = Colors.red;
                            description = "کنسل شد";
                          }
                          break;
                        case "3":
                          {
                            cl = Colors.pink;
                            description = "در حال پیگیری";
                          }
                          break;
                        case "4":
                          {
                            cl = Colors.yellow;
                            description = "ارسال محتوا انجام شد";
                          }
                          break;
                        case "5":
                          {
                            cl = Colors.deepOrangeAccent;
                            description = "مشتری پاسخ گو تماس نبود";
                          }
                          break;
                        case "6":
                          {
                            cl = Colors.cyan;
                            description = "ارسال نمونه انجام شد";
                          }
                          break;
                        case "7":
                          {
                            cl = Colors.lightGreen;
                            description = "قرار ملاقات تنظیم شد";
                          }
                          break;
                        case "8":
                          {
                            cl = Colors.deepPurple;
                            description = "مشتری به فرد دیگری انتقال شد";
                          }
                          break;
                        case "9":
                          {
                            cl = Colors.blue;
                            description = snapshot.data![index].comment;
                          }
                          break;
                      }
                      return EasyCard(
                          prefixBadge: cl,
                          suffixBadge: cl,
                          date: snapshot.data![index].setDateTime
                              .toPersianDateStr(showDayStr: true),
                          iconColor: Colors.transparent,
                          title: snapshot.data![index].customerName,
                          description: description,
                          mobile: snapshot.data![index].customerMobile
                              .toPersianDigit(),
                          suffixIconColor: Colors.transparent,
                          press: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CustomerCallScreen(
                                mobile: snapshot.data![index].customerMobile,
                                userCreated: false,
                                userId: UserLoginDetail.userId,
                              );
                            }));
                          },
                          backgroundColor: Colors.white,
                          descriptionColor: Colors.black,
                          titleColor: Colors.black);
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
