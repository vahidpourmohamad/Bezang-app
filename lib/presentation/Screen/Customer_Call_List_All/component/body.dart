import 'dart:core';
import 'package:bestbuy/Data/dataprovider/CallDataLogic.dart';
import 'package:bestbuy/Data/model/CallDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/constant/color.dart';

import 'package:bestbuy/presentation/Screen/Customer_Call_Status_List/CustomerCallStatusListScreen.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/widget/EasyCard.dart';
import 'package:bestbuy/presentation/widget/rounded_drop_dwon.dart';
import 'package:bestbuy/presentation/widget/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'background.dart';
import 'package:shamsi_date/shamsi_date.dart';
//import 'package:shamsi_date/extensions.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final textNameController = TextEditingController();
  final dropDownStatusController = TextEditingController();
  final textHashTagsController = TextEditingController();
  String toDate = "1404/1/1";
  String fromDate = "1403/1/1";

  void showDateDialogFrom(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('انتخاب تاریخ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'iransans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              content: LinearDatePicker(
                initialDate: fromDate,
                dateChangeListener: (String selectedDate) {
                  fromDate = selectedDate;
                },
                labelStyle: TextStyle(
                  fontFamily: 'iransans',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.black,
                ),
                selectedRowStyle: TextStyle(
                  fontFamily: 'iransans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.deepOrange,
                ),
                unselectedRowStyle: TextStyle(
                  fontFamily: 'iransans',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.blueGrey,
                ),
                showMonthName: true,
                isJalaali: true,
                columnWidth: 80,
              ),
            ));
  }

  void showDateDialogTo(BuildContext context) {
    print(toDate);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('انتخاب تاریخ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'iransans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              content: LinearDatePicker(
                initialDate: toDate.toEnglishDigit(),
                dateChangeListener: (String selectedDate) {
                  toDate = selectedDate;
                },
                labelStyle: TextStyle(
                  fontFamily: 'iransans',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.black,
                ),
                selectedRowStyle: TextStyle(
                  fontFamily: 'iransans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.deepOrange,
                ),
                unselectedRowStyle: TextStyle(
                  fontFamily: 'iransans',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.blueGrey,
                ),
                showMonthName: true,
                isJalaali: true,
                columnWidth: 80,
              ),
            ));
  }

  Future<List<CallDataModel>> loadingData() async {
    List<CallDataModel> temp;
    String mobile = "";
    String name = "";
    if (textNameController.value.text.toEnglishDigit().isNumeric() == true) {
      mobile = textNameController.value.text.toString().toEnglishDigit();
    } else {
      if (textNameController.value.text.toString() != "") {
        name = textNameController.value.text.toString();
      }
    }
//print(int.parse(toDate.toEnglishDigit().split("/")[0]));
//    print(toDate.toEnglishDigit().split("/")[1]);
//    print(toDate.toEnglishDigit().split("/")[2]);

    Gregorian fromDateG = Gregorian.fromJalali(Jalali(
        int.parse(fromDate.toEnglishDigit().split("/")[0]),
        int.parse(fromDate.toEnglishDigit().split("/")[1]),
        int.parse(fromDate.toEnglishDigit().split("/")[2])));
    Gregorian toDateG = Gregorian.fromJalali(Jalali(
        int.parse(toDate.toEnglishDigit().split("/")[0]),
        int.parse(toDate.toEnglishDigit().split("/")[1]),
        int.parse(toDate.toEnglishDigit().split("/")[2])));
    temp = await CallDataLogic.findCallBySetting(
        fromDateG.toDateTime().toString(),
        toDateG.toDateTime().toString(),
        mobile,
        name,
        "0",
        textHashTagsController.value.text,
        UserLoginDetail.userId);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CallDataModel>>(
        future: loadingData(),
        builder: (context, AsyncSnapshot<List<CallDataModel>> snapshot) {
          if (snapshot.hasData) {
            //Size size = MediaQuery.of(context).size;
            return Background(
                child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 15.0,
                        )
                      ]),
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 20, left: 10, right: 20),
                          child: Column(children: [
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 1),
                                  child: Text(
                                    "پارامترهای جستجو مشتریان",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontFamily: 'iransans'),
                                  ),
                                )),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(29),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                elevation: 5.0,
                                                shadowColor: LightColor
                                                    .kPrimaryLightColor,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                backgroundColor: kPrimaryColor),
                                            onPressed: () {
                                              showDateDialogFrom(context);
                                              setState(() {});
                                            },
                                            child: Text(
                                              "از " +
                                                  "  " +
                                                  fromDate.toPersianDigit(),
                                              style: TextStyle(
                                                  fontFamily: 'iransans',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(29),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                elevation: 5.0,
                                                shadowColor: LightColor
                                                    .kPrimaryLightColor,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                backgroundColor: kPrimaryColor),
                                            onPressed: () {
                                              showDateDialogTo(context);
                                              setState(() {});
                                            },
                                            child: Text(
                                              "تا" +
                                                  "   " +
                                                  toDate.toPersianDigit(),
                                              style: TextStyle(
                                                  fontFamily: 'iransans',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(children: [
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.055,
                                        decoration: BoxDecoration(
                                          color: kPrimaryLightColor,
                                          borderRadius:
                                              BorderRadius.circular(29),
                                        ),
                                        child: TextField(
                                          onChanged: (value) {},
                                          textAlign: TextAlign.right,
                                          cursorColor: kPrimaryColor,
                                          maxLines: 1,
                                          controller: textNameController,
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.account_box,
                                              color: kPrimaryColor,
                                            ),
                                            hintText: "نام یا موبایل مشتری",
                                            border: InputBorder.none,
                                          ),
                                        )),
                                    RoundedDropDown(
                                        hintText: "آخرین وضعیت مشتری",
                                        dValues: [
                                          "مشغول",
                                          "موفق",
                                          "ناموفق",
                                          "پیگیری",
                                          "ارسال نامه",
                                          "ارسال نمونه",
                                          "جلسه",
                                          "ارسال به دیگری",
                                          "دیگر"
                                        ],
                                        onChanged: (value) {},
                                        controller: dropDownStatusController,
                                        icon: Icons.call,
                                        size: Size(
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                            MediaQuery.of(context).size.height *
                                                0.055)),
//                                    RoundedInputField(
//                                        hintText: "نام و یا موبایل",
//                                        onChanged: (value) {},
//                                        controller: textNameController)
                                  ])
//                              Text(
//                                "مشتریان شما",
//                                style: TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 16,
//                                    fontFamily: 'iransans'),
//                              ),
                                ]),
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 1),
                                    child: RoundedInputField(
                                      wordSpace: 4,
                                      hintText:
                                          "#خریدار#220متر#بیمه_عمر#پرینتر و یا هر چیز دیگری   برای این مخاطب اولین هشتگ را بنویسید",
                                      onChanged: (value) {},
                                      maxLine: 1,
                                      controller: textHashTagsController,
                                    ))),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      elevation: 5.0,
                                      shadowColor:
                                          LightColor.kPrimaryLightColor,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 40),
                                      backgroundColor: kPrimaryColor),
                                  onPressed: () {
                                    setState(() {
                                      loadingData();
                                    });
                                  },
                                  child: Text(
                                    "جستجو",
                                    style: TextStyle(
                                        fontFamily: 'iransans',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ])))),
              Expanded(
                  // The ListView
                  child: ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey,
                ),
                itemBuilder: (context, index) {
                  Color badgeColor = Colors.black;
                  String description = "";
                  switch (snapshot.data![index].status) {
                    case "1":
                      {
                        badgeColor = Colors.green;
                        description = "فروش موفق انجام شد";
                      }
                      break;
                    case "2":
                      {
                        badgeColor = Colors.red;
                        description = "کنسل شد";
                      }
                      break;
                    case "3":
                      {
                        badgeColor = Colors.pink;
                        description = "در حال پیگیری";
                      }
                      break;
                    case "4":
                      {
                        badgeColor = Colors.yellow;
                        description = "ارسال محتوا انجام شد";
                      }
                      break;
                    case "5":
                      {
                        badgeColor = Colors.deepOrangeAccent;
                        description = "مشتری پاسخ گو تماس نبود";
                      }
                      break;
                    case "6":
                      {
                        badgeColor = Colors.cyan;
                        description = "ارسال نمونه انجام شد";
                      }
                      break;
                    case "7":
                      {
                        badgeColor = Colors.lightGreen;
                        description = "قرار ملاقات تنظیم شد";
                      }
                      break;
                    case "8":
                      {
                        badgeColor = Colors.deepPurple;
                        description = "مشتری به فرد دیگری انتقال شد";
                      }
                      break;
                    case "9":
                      {
                        badgeColor = Colors.blue;
                        description = snapshot.data![index].comment;
                      }
                      break;
                  }
                  return EasyCard(
                      prefixBadge: badgeColor,
                      suffixBadge: badgeColor,
                      date: snapshot.data![index].creationDateTime
                          .toPersianDateStr(showDayStr: true),
                      iconColor: Colors.transparent,
                      title: snapshot.data![index].customerName,
                      description: description,
                      mobile:
                          snapshot.data![index].customerMobile.toPersianDigit(),
                      suffixIconColor: Colors.transparent,
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerCallStatusListScreen(
                            mobile: snapshot.data![index].customerMobile,
                            name: snapshot.data![index].customerName,
                            userId: UserLoginDetail.userId,
                          );
                        }));
                      },
                      backgroundColor: Colors.white,
                      descriptionColor: Colors.black,
                      titleColor: Colors.black);
                },
              ))
            ]));
          } else {
            if (snapshot.hasError) {
              print("ERROR  " + snapshot.error.toString());
            }
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        });
  }
}
