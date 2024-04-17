import 'dart:math';

import 'package:bestbuy/Data/dataprovider/DataProviderConfig.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/Customer_Call/CustomerCallScreen.dart';
import 'package:bestbuy/presentation/Screen/Customer_Call_List/component/background.dart';
import 'package:bestbuy/presentation/Screen/customer_add/customer_add_screen.dart';
import 'package:bestbuy/presentation/widget/rounded_drop_dwon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NewCall extends StatefulWidget {
  NewCall({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NewCall createState() => _NewCall();
}

class _NewCall extends State<NewCall> {
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
  String bankSelected = "";
  final TextEditingController textBankController = TextEditingController();

  Future<List<dynamic>> getBank() async {
//    if( UserLoginDetail.paymentStatus ==false)
//    {
//      Navigator.(
//        context,
//        MaterialPageRoute(
//          builder: (context) {
//            return CustomerAddScreen();
//          },
//        ),
//      );
//    }
    try {
      var response = await Dio().get(nodeJsUrl + '/getbanks');

      List<dynamic> jsonMap = response.data; //jsonDecode();
      // = jsonDecode(response.data);
      print(jsonMap[0]["name"]);
      return (jsonMap);
    } catch (e) {
      print(e);
      throw '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<dynamic>>(
        future: getBank(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var banks = <String>[]; // List<String> job= List<String>();
            for (var i = 0; i < snapshot.data!.length; i++) {
              banks.add(snapshot.data![i]["name"]);
            }
            return Scaffold(
                body: Background(
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          height: size.height - 150,
                          color: Color(0xfff9f9f9),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            dragStartBehavior: DragStartBehavior.down,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                UserLoginDetail.paymentStatus
                                    ? Container(
                                        child: Column(children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.07),
                                            child: Container(
                                                height: size.height * 0.25,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: randomColors[
                                                            Random()
                                                                .nextInt(9)],
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          20,
                                                                      horizontal:
                                                                          20),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                        width: size.width *
                                                                            0.5,
                                                                        child:
                                                                            Text(
                                                                          "دریافت از بانک",
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              fontFamily: 'iransans'),
                                                                        )),
                                                                    Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.5,
                                                                        child:
                                                                            Text(
                                                                          "می توانید از بانک اطلاعات موجود در سیستم بفروش استفاده کنید البته این قابلیت فقط برای اعضای طلایی قابل استفاده است",
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 12,
                                                                              fontFamily: 'iransans'),
                                                                        )),
                                                                  ]))),
                                                      Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10),
                                                            child:
                                                                GestureDetector(
                                                              //this is for OK
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomerCallScreen(
                                                                          mobile:
                                                                              bankSelected,
                                                                          userCreated:
                                                                              false);
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width:
                                                                    size.width *
                                                                        0.2,
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/Bank.png",
                                                                  //width: double.infinity,
                                                                  height:
                                                                      size.height *
                                                                          0.5,
                                                                ),
                                                              ),
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                  RoundedDropDown(
                                                    hintText:
                                                        "انتخاب بانک اطلاعات",
                                                    onChanged: (value) {
                                                      bankSelected = value;
                                                    },
                                                    icon: Icons.build_sharp,
                                                    controller:
                                                        textBankController,
                                                    dValues: banks,
                                                    size: Size(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06), //snapshot.data!.cast<String>(),
                                                  ),
                                                ]))),
                                        // _search(),,
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: size.width * 0.07),
                                            child: Container(
                                                height: 170,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: randomColors[
                                                            Random()
                                                                .nextInt(9)],
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        20,
                                                                    horizontal:
                                                                        20),
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                      width: size
                                                                              .width *
                                                                          0.5,
                                                                      child:
                                                                          Text(
                                                                        "از بانک شخصی",
                                                                        textAlign:
                                                                            TextAlign.justify,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                'iransans'),
                                                                      )),
                                                                  Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.5,
                                                                      child:
                                                                          Text(
                                                                        "شما می توانید از مشتریانی که قبلا ثبت کردید استقاده کنید و سیستم به طور هوشمند یک مشتری را برای شما انتخاب می کند",
                                                                        textAlign:
                                                                            TextAlign.justify,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .normal,
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                'iransans'),
                                                                      ))
                                                                ]))),
                                                    Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      10),
                                                          child:
                                                              GestureDetector(
                                                            //this is for OK
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return CustomerCallScreen(
                                                                        mobile: UserLoginDetail
                                                                            .userId,
                                                                        userCreated:
                                                                            false);
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              height: 100,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.2,
                                                              color: Colors
                                                                  .transparent,
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/shakhsi.png",
                                                                //width: double.infinity,
                                                                height:
                                                                    size.height *
                                                                        0.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                  ],
                                                ))),
                                      ]))
                                    : Container(),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.07),
                                    child: Container(
                                        height: 170,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: randomColors[
                                                    Random().nextInt(9)],
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 20,
                                                            horizontal: 20),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5,
                                                              child: Text(
                                                                "ثبت مشتری جدید",
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        'iransans'),
                                                              )),
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5,
                                                              child: Text(
                                                                "ثبت مشتری جدید و تماس قابل همزمان لازم به توضیح است که موارد ثبت شده فقط در بانک شما ذخیره می شود و برای شما نمایش داده می شود",
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'iransans'),
                                                              ))
                                                        ]))),
                                            Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: GestureDetector(
                                                    //this is for OK
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return CustomerAddScreen();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 100,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      color: Colors.transparent,
                                                      child: Image.asset(
                                                        "assets/images/new.png",
                                                        //width: double.infinity,
                                                        height:
                                                            size.height * 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ))),
                              ],
                            ),
                          ),
                        ))));
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        });
  }
}
