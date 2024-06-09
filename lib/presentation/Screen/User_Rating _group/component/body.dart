import 'dart:core';
import 'package:bestbuy/Data/dataprovider/UserRanksDataLogic.dart';
import 'package:bestbuy/Data/model/UserRankDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/CDR_Status_User/CDRStatusUserScreen.dart';
import 'package:bestbuy/presentation/Screen/InProgressCall/InProgressCallScreen.dart';
import 'package:bestbuy/presentation/Screen/TodayActions/TodayActionsListScreen.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:flutter/material.dart';

import 'package:persian_number_utility/persian_number_utility.dart';
import 'background.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Sample data type.
/// Sample linear data type.
class LinearCallCount {
  final int count;
  final int status;
  final String statusName;

  LinearCallCount(this.count, this.status, this.statusName);
}

class Body extends StatefulWidget {
  final bool managerPermit;
  final String id;
  final String name;
  final String internal;

  const Body(
      {Key? key,
      required this.managerPermit,
      required this.id,
      required this.name,
      required this.internal})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final textNameController = TextEditingController();
  final dropDownStatusController = TextEditingController();

  Future<UserRankDataModel> loadingData() async {
    // UserDataModel temp;
    // String t;
    UserRankDataModel ud = await UserRankDataLogic.readUserReport(widget.id);
    print(widget.id);

    print("test");
    //UserRankDataModel ud = UserRankDataModel.stringToModel(t);
    return ud;
  }

  static List<LinearCallCount> _createMonthSampleData(
      UserRankDataModel userRank) {
    final data = [
      new LinearCallCount(1, int.parse(userRank.statusMonth1), "موفق"),
      new LinearCallCount(3, int.parse(userRank.statusMonth3), "در حال پیگیری"),
      new LinearCallCount(2, int.parse(userRank.statusMonth2), "کنسل"),
    ];

    return data;
  }

  static List<LinearCallCount> _createSampleData(UserRankDataModel userRank) {
    final data = [
      new LinearCallCount(3, int.parse(userRank.statusDay3), "در حال پیگیری"),
      new LinearCallCount(1, int.parse(userRank.statusDay1), "موفق"),
      new LinearCallCount(2, int.parse(userRank.statusDay2), "کنسل"),
      new LinearCallCount(4, int.parse(userRank.statusDay4), "محتوا"),
      new LinearCallCount(5, int.parse(userRank.statusDay5), "جواب نداد"),
      new LinearCallCount(6, int.parse(userRank.statusDay6), "ارسال نمونه"),
      new LinearCallCount(7, int.parse(userRank.statusDay7), "جلسه"),
      new LinearCallCount(8, int.parse(userRank.statusDay8), "اانتقال"),
      new LinearCallCount(9, int.parse(userRank.statusDay8), "دیگر"),
    ];

    return data;
  }

  final bool animate = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserRankDataModel>(
        future: loadingData(),
        builder: (context, AsyncSnapshot<UserRankDataModel> snapshot) {
          if (snapshot.hasData) {
            String Avg = snapshot.data!.averageSec.toPersianDigit();
            if (Avg == "NaN") {
              Avg = "0";
            }
            Avg = Avg.split(".")[0];
            //Size size = MediaQuery.of(context).size;
            return Background(
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 75,
                                  ),
                                  Text(
                                    DateTime.now()
                                        .toPersianDateStr(showDayStr: true),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: 14,
                                        fontFamily: 'iransans'),
                                  )
                                ]),
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom: 4.0,
                            ),
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  color: Colors.blue,
                                  fontFamily: 'iransans'),
                            ),
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom: 4.0,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "امتیاز ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'iransans'),
                                  ),
                                  Text(
                                    snapshot.data!.callDay.toPersianDigit(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        color: Colors.green,
                                        fontFamily: 'iransans'),
                                  ),
                                ]),
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom: 4.0,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "تعداد پیگیری امروز",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'iransans'),
                                  ),
                                  Text(
                                    snapshot.data!.callDay.toPersianDigit(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        color: Colors.redAccent,
                                        fontFamily: 'iransans'),
                                  ),
                                ]),
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom: 7.0,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            bottom: 1,
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("تعداد تماس خروجی",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'iransans')),
                                                Text(
                                                    snapshot.data!.callCount
                                                        .toPersianDigit(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.amber,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'iransans')),
                                              ]))),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            bottom: 1,
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("میانگین تماس ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'iransans')),
                                                Text(Avg.toPersianDigit(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'iransans')),
                                              ]))),
                                ]),
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.005,
                              bottom: 1,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            bottom: 1,
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("مجموع زمان مکالمات",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'iransans')),
                                                Text(
                                                    snapshot.data!.totalSec
                                                        .toPersianDigit(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: Colors.pink,
                                                        fontFamily:
                                                            'iransans')),
                                              ]))),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            bottom: 1,
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("بیشترین",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'iransans')),
                                                Text(
                                                    snapshot.data!.maxCallTime
                                                        .toPersianDigit(),
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'iransans')),
                                              ]))),
                                ]),
                          )),

                      RoundedButton(
                        text: "نمایش پیگری ها",
                        color: Colors.pink,
                        press: () {
                          if (widget.managerPermit == true) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return InProgressCallScreen(
                                  name: widget.name, id: widget.id);
                            }));
                          } else {}
//
                        },
                      ),
                      RoundedButton(
                        color: Colors.deepOrange,
                        text: "نمایش تماس های امروز",
                        press: () {
                          if (widget.managerPermit == true) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CDRStatusUserScreen(
                                name: widget.name,
                                reportDay: DateTime.now(),
                                internal: widget.internal,
                              );
                            }));
                          } else {}
                        },
                      ),
                      RoundedButton(
                        color: Colors.blueGrey,
                        text: "نمایش رویداد های امروز",
                        press: () {
                          if (widget.managerPermit == true) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TodayActionsListScreen(
                                  name: widget.name,
                                  ReportDay: DateTime.now(),
                                  id: widget.id);
                            }));
                          } else {}
                        },
                      ),
                      SfCircularChart(
                          series: <PieSeries<LinearCallCount, String>>[
                            PieSeries<LinearCallCount, String>(
                                explode: true,
                                explodeIndex: 0,
                                // Bind data source
                                dataSource: _createSampleData(snapshot.data!),
                                xValueMapper: (LinearCallCount data, _) =>
                                    data.count.toString(),
                                yValueMapper: (LinearCallCount data, _) =>
                                    data.status,
                                dataLabelMapper: (LinearCallCount data, _) =>
                                    data.statusName,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true))
                          ]),
                      SfCircularChart(
                          series: <PieSeries<LinearCallCount, String>>[
                            PieSeries<LinearCallCount, String>(
                                explode: true,
                                explodeIndex: 0,
                                // Bind data source
                                dataSource:
                                    _createMonthSampleData(snapshot.data!),
                                xValueMapper: (LinearCallCount data, _) =>
                                    data.count.toString(),
                                yValueMapper: (LinearCallCount data, _) =>
                                    data.status,
                                dataLabelMapper: (LinearCallCount data, _) =>
                                    data.statusName,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true))
                          ]),
//
//
                    ]))));
          } else {
            if (snapshot.hasError) {
              print("ERROR  " + snapshot.error.toString());
            }
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  color: LightColor.kPrimaryColor,
                ));
          }
        });
  }
}
