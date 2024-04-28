import 'dart:io';

import 'package:bestbuy/Data/dataprovider/CallDataLogic.dart';
import 'package:bestbuy/Data/dataprovider/UserDataLogic.dart';
import 'package:bestbuy/Data/model/CDRDataModel.dart';

import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/config/setting.dart';
import 'package:bestbuy/presentation/Screen/CDR_Status_User/CDRStatusUserScreen.dart';

import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/widget/CDRHistoryStatusCard.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:dartssh2/dartssh2.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'background.dart';

class Body extends StatefulWidget {
  final DateTime reportDay;
  final String name;
  final String internal;

  const Body(
      {Key? key,
      required this.reportDay,
      required this.name,
      required this.internal})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final player = AudioPlayer();

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
  void dispose() async {
    player.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CDRDataModel>>(
        future: CallDataLogic.readCDRByInternalByDay(
            widget.reportDay, widget.internal),
        builder: (context, AsyncSnapshot<List<CDRDataModel>> snapshot) {
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
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: Setting.mediaSize.height * 00.05,
                            left: 10,
                            right: 20),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: Setting.mediaSize.height * 0.07,
                                    bottom: 0,
                                    left: 10,
                                    right: 20),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              widget.reportDay.toPersianDate(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  fontFamily: 'iransans'),
                                            ),
                                            Text(
                                              widget.name,
                                              // Jalali.now().year.toString()+"/"+Jalali.now().month.toString()+"/"+Jalali.now().day.toString()+"امروز ",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: 'iransans'),
                                            )
                                          ]),
                                      RoundedButton(
                                        text: "روز بعد",
                                        press: () {
                                          final now = widget.reportDay;

                                          final tomorrow = DateTime(
                                              now.year, now.month, now.day + 1);

                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CDRStatusUserScreen(
                                              name: UserLoginDetail.userName,
                                              reportDay: tomorrow,
                                              internal: widget.internal,
                                            );
                                          }));
                                        },
                                        color: Colors.blue,
                                      ),
                                      RoundedButton(
                                          color: Colors.red,
                                          text: "روز قبل",
                                          press: () {
                                            final now = widget.reportDay;

                                            final yesterday = DateTime(now.year,
                                                now.month, now.day - 1);

                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return CDRStatusUserScreen(
                                                name: UserLoginDetail.userName,
                                                reportDay: yesterday,
                                                internal: widget.internal,
                                              );
                                            }));
                                          }),
                                    ]))),
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
                      Color cl = Colors.green;
                      String description = "مدت زمان :" +
                          snapshot.data![index].duration.toString() +
                          " ثانبه";

                      return CDRHistoryStatusCard(
                          comment: "",
                          prefixBadge: cl,
                          suffixBadge: cl,
                          date: snapshot.data![index].callDate
                              .toPersianDateStr(showDayStr: true),
                          iconColor: Colors.transparent,
                          title: "تماس خروجی موفق",
                          description: description,
                          mobile: snapshot.data![index].destination
                              .toPersianDigit(),
                          suffixIconColor: Colors.transparent,
                          press: () async {
                            // if(UserLoginDetail.APICode=="RumbaHolding")
                            // {
                            // }

                            final client = SSHClient(
                              await SSHSocket.connect('192.168.1.100', 22),
                              username: 'root',
                              onPasswordRequest: () => 'cmpwx5u6',
                            );
                            final sftp = await client.sftp();
                            final file = await sftp.open(
                                '/var/spool/asterisk/monitor/' +
                                    snapshot.data![index].voice.substring(6));
                            final content = await file.readBytes();
                            File((await getTemporaryDirectory()).path +
                                    "/" +
                                    snapshot.data![index].voice.substring(6))
                                .writeAsBytes(content);
                            final test = await File(
                                    (await getTemporaryDirectory()).path +
                                        "/" +
                                        snapshot.data![index].voice
                                            .substring(6))
                                .exists();
                            if (test == true) {
                              await player.play(DeviceFileSource(
                                  (await getTemporaryDirectory()).path +
                                      "/" +
                                      snapshot.data![index].voice
                                          .substring(6)));
                            }
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
