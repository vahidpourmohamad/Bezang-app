import 'dart:core';
import 'package:bestbuy/Data/dataprovider/UserRanksDataLogic.dart';
import 'package:bestbuy/Data/model/UserRankDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final textNameController = TextEditingController();
  final dropDownStatusController = TextEditingController();

  Future<UserRankDataModel> loadingData() async {
   // UserDataModel temp;
   // String t;
    UserRankDataModel ud = await UserRankDataLogic.readUserReport(UserLoginDetail.userId);
    //UserRankDataModel ud = UserRankDataModel.stringToModel(t);
    return ud;
  }
  static List<LinearCallCount> _createMonthSampleData(UserRankDataModel userRank) {
    final data = [
      new LinearCallCount(1, int.parse(userRank.statusMonth1), "موفق"),
      new LinearCallCount(2, int.parse(userRank.statusMonth2), "کنسل"),
      new LinearCallCount(3, int.parse(userRank.statusMonth3), "در حال پیگیری"),
    ];

    return data;
  }
  static List<LinearCallCount> _createSampleData(UserRankDataModel userRank) {
    final data = [
      new LinearCallCount(1, int.parse(userRank.statusDay1), "موفق"),
      new LinearCallCount(2, int.parse(userRank.statusDay2), "کنسل"),
      new LinearCallCount(3, int.parse(userRank.statusDay3), "در حال پیگیری"),
//      new LinearCallCount(4, int.parse(userRank.statusDay4), "محتوا"),
//      new LinearCallCount(5, int.parse(userRank.statusDay5), "جواب نداد"),
//      new LinearCallCount(6, int.parse(userRank.statusDay6), "ارسال نمونه"),
//      new LinearCallCount(7, int.parse(userRank.statusDay7), "جلسه"),
//      new LinearCallCount(8, int.parse(userRank.statusDay8), "اانتقال"),
//      new LinearCallCount(9, int.parse(userRank.statusDay9), "دیگر"),
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
            //Size size = MediaQuery.of(context).size;
            return Background(
                child: Directionality(
                    textDirection: TextDirection.rtl,
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
                              bottom: 7.0,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "امتیاز شما",
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
                              bottom: 7.0,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "تعداد تماس امروز",
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
//
                    ])));
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
