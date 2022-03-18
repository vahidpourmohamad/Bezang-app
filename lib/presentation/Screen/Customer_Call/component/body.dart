import 'package:bestbuy/Data/dataprovider/CallDataLogic.dart';
import 'package:bestbuy/Data/dataprovider/CustomerDataLogic.dart';
import 'package:bestbuy/Data/model/CallDataModel.dart';
import 'package:bestbuy/Data/model/CustomerDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/Customer_Call_Status_List/CustomerCallStatusListScreen.dart';


import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:bestbuy/presentation/widget/RoundedButtonwithsize.dart';
import 'package:bestbuy/presentation/widget/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';

import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/extensions.dart';
import 'background.dart';

class Body extends StatefulWidget {
  final String mobile;
  final bool userCreated;

  const Body({Key? key, required this.mobile,required this.userCreated}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final textDescriptionController = TextEditingController();
  final textHashTagsController = TextEditingController();

  int callResultStatus = 3;
  bool tomorrow = false;
  bool pastTomorrow = false;
  bool twoDays = false;
  bool calender = false;

  String inProgressDate =
      DateTime.now().add(Duration(days: 5)).toPersianDate().toEnglishDigit();
  bool inProgressDateShow = true;

  void _handleTap({required int callResultStatusP}) {
    setState(() {
      if (callResultStatusP == 8) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("این قابلیت فعلا غیر فعال است")));
      } else {
        if (callResultStatusP == 1 ||
            callResultStatusP == 2 ||
            callResultStatusP == 9) {
          inProgressDate = "2030/01/01";
        }

        if (callResultStatusP == 5) {
          inProgressDate = DateTime.now().add(Duration(hours: 2)).toString();
        }
        callResultStatus = callResultStatusP;
      }
    });
  }

  void _changed(bool visibility) {
    setState(() {
      inProgressDateShow = visibility;
    });
  }

  void showDateDialog(BuildContext context) {
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
//                initialDate: DateTime.now()
//                    .add(Duration(days: 5))
//                    .toPersianDate()
//                    .toEnglishDigit(),
                dateChangeListener: (String selectedDate) {
                  inProgressDate = selectedDate;
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
                showDay: true,
                isJalaali: true,
                columnWidth: 80,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CustomerDataModel>(
        future: CustomerDataLogic.readOneCustomerByBankUserCall(
            widget.mobile, UserLoginDetail.userId,widget.userCreated),
        builder: (context, AsyncSnapshot<CustomerDataModel> snapshot) {
          if (snapshot.hasData) {
            Size size = MediaQuery.of(context).size;

            return Background(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 40.0,
                              top: MediaQuery.of(context).size.height * 0.2,
                              bottom: 7.0,
                              right: 40),
                          child: Text(
                            "نام و نام خانوادگی",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'iransans'),
                          ),
                        )),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 40),
                          child: Text(
                            snapshot.data!.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'iransans'),
                          ),
                        )),
                    snapshot.data!.company.isEmpty
                        ? Container()
                        : Column(children: [
                            Divider(
                              color: Color(0xffeeeeee),
                              height: 15,
                              thickness: 1,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 35),
                                  child: Text(
                                    "نام کسب و کار",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'iransans'),
                                  ),
                                )),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 40),
                                  child: Text(
                                    snapshot.data!.company,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'iransans'),
                                  ),
                                ))
                          ]),
                    snapshot.data!.comment.isEmpty
                        ? Container()
                        : Column(children: [
                            Divider(
                              color: Color(0xffeeeeee),
                              height: 15,
                              thickness: 1,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 40),
                                  child: Text(
                                    "توضیحات",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'iransans'),
                                  ),
                                )),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  snapshot.data!.comment,
                                  textAlign: TextAlign.justify,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'iransans'),
                                ))
                          ]),
                    Divider(
                      color: Color(0xffeeeeee),
                      height: 15,
                      thickness: 1,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 60),
                          child: Text(
                            "هشتگ ها",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'iransans'),
                          ),
                        )),
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
                              maxLine: 4,
                              controller: textHashTagsController,
                            ))),
                    Divider(
                      color: Color(0xffeeeeee),
                      height: 15,
                      thickness: 1,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 40),
                          child: Text(
                            "شماره تماس",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'iransans'),
                          ),
                        )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 1),
                                child: RoundedButtonWithSize(
                                    text: "تماس",
                                    press: () {
                                     // ScaffoldMessenger.of(context)
                                    //      .showSnackBar(SnackBar(
                                    //    content: Text("test"),
                                    //  ));
                                    }, // _callNumber("09151101602"),
                                    size: MediaQuery.of(context).size * 0.4))),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 1),
                              child: Text(
                                snapshot.data!.telephone.toPersianDigit(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: 'iransans'),
                              ),
                            ))
                      ],
                    )),
                    Divider(
                      color: Color(0xffeeeeee),
                      height: 15,
                      thickness: 1,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 1),
                            child: RoundedButtonWithSize(
                                color: Colors.lightGreen,
                                text: " نمایش سابقه تماسها با مشتری",
                                press: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return CustomerCallStatusListScreen(
                                            mobile: snapshot.data!.telephone,name:snapshot.data!.name);
                                      }));

                                }, // _callNumber("09151101602"),
                                size: MediaQuery.of(context).size * 0.8))),
                    Divider(
                      color: Color(0xffeeeeee),
                      height: 15,
                      thickness: 1,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 40),
                          child: Text(
                            "نتیجه تماس",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'iransans'),
                          ),
                        )),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 7, top: 1, bottom: 7.0, right: 7),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    //this is for OK
                                    onTap: () {
                                      _handleTap(callResultStatusP: 1);
                                      _changed(false);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 1
                                            ? "assets/images/OkActive.png"
                                            : "assets/images/OkdeActive.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    //this is for OK
                                    onTap: () {
                                      _handleTap(callResultStatusP: 2);
                                      _changed(false);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 2
                                            ? "assets/images/Ocancel.png"
                                            : "assets/images/cancel.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    //this is for peygiri
                                    onTap: () {
                                      _handleTap(callResultStatusP: 3);
                                      _changed(true);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 3
                                            ? "assets/images/Opeygiri.png"
                                            : "assets/images/peygiri.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                ]))),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 7),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    //this is for content
                                    onTap: () {
                                      _handleTap(callResultStatusP: 4);
                                      _changed(true);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 4
                                            ? "assets/images/Ocontentsend.png"
                                            : "assets/images/contentsend.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    //this is for JN
                                    onTap: () {
                                      _handleTap(callResultStatusP: 5);
                                      _changed(false);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 5
                                            ? "assets/images/OJN.png"
                                            : "assets/images/JN.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    //this is for nemone
                                    onTap: () {
                                      _handleTap(callResultStatusP: 6);
                                      _changed(true);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 6
                                            ? "assets/images/Onemone.png"
                                            : "assets/images/nemone.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                ]))),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 7),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    //this is for Jalase
                                    onTap: () {
                                      _handleTap(callResultStatusP: 7);
                                      _changed(true);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 7
                                            ? "assets/images/Ometting.png"
                                            : "assets/images/metting.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    //this is for transfer
                                    onTap: () {
                                      _handleTap(callResultStatusP: 8);
                                      _changed(false);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 8
                                            ? "assets/images/Otransfer.png"
                                            : "assets/images/transfer.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    //this is for Other
                                    onTap: () {
                                      _handleTap(callResultStatusP: 9);
                                      _changed(false);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        callResultStatus == 9
                                            ? "assets/images/Oother.png"
                                            : "assets/images/other.png",
                                        //width: double.infinity,
                                        height: size.height * 0.5,
                                      ),
                                    ),
                                  ),
                                ]))),
                    inProgressDateShow
                        ? Column(children: [
                            Divider(
                              color: Color(0xffeeeeee),
                              height: 15,
                              thickness: 1,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 40),
                                  child: Text(
                                    " تاریخ تماس بعدی" +
                                        " : " +
                                        inProgressDate.toPersianDigit(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'iransans'),
                                  ),
                                )),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    width: MediaQuery.of(context).size.width *
                                        0.225,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            elevation: 3.0,
                                            shadowColor: LightColor.orange,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            backgroundColor: calender
                                                ? Colors.lightGreen
                                                : Colors.black26),
                                        onPressed: () {
                                          //  inProgressDate =
                                          //      DateTime.now().add(Duration(days: 3)).toPersianDate().toEnglishDigit();
                                          tomorrow = false;
                                          pastTomorrow = false;
                                          calender = true;
                                          twoDays = false;
                                          showDateDialog(context);
                                          setState(() {});
                                        },
                                        child: Text(
                                          inProgressDate.toPersianDigit(),
                                          style: TextStyle(
                                              fontFamily: 'iransans',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    width: MediaQuery.of(context).size.width *
                                        0.225,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            elevation: 3.0,
                                            shadowColor: LightColor.orange,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            backgroundColor: twoDays
                                                ? Colors.orange
                                                : Colors.black26),
                                        onPressed: () {
                                          inProgressDate = DateTime.now()
                                              .add(Duration(days: 3))
                                              .toPersianDate()
                                              .toEnglishDigit();
                                          tomorrow = false;
                                          pastTomorrow = false;
                                          calender = false;
                                          twoDays = true;
                                          //showDateDialog(context);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "سه روز",
                                          style: TextStyle(
                                              fontFamily: 'iransans',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    width: MediaQuery.of(context).size.width *
                                        0.225,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            elevation: 3.0,
                                            shadowColor: LightColor.orange,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            backgroundColor: pastTomorrow
                                                ? Colors.orange
                                                : Colors.black26),
                                        onPressed: () {
                                          inProgressDate = DateTime.now()
                                              .add(Duration(days: 2))
                                              .toPersianDate()
                                              .toEnglishDigit();
                                          tomorrow = false;
                                          pastTomorrow = true;
                                          calender = false;
                                          twoDays = false;
                                          //  showDateDialog(context);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "پس فردا",
                                          style: TextStyle(
                                              fontFamily: 'iransans',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    width: MediaQuery.of(context).size.width *
                                        0.225,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            elevation: 3.0,
                                            shadowColor: LightColor.orange,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            backgroundColor: tomorrow
                                                ? Colors.orange
                                                : Colors.black26),
                                        onPressed: () {
                                          inProgressDate = DateTime.now()
                                              .add(Duration(days: 1))
                                              .toPersianDate()
                                              .toEnglishDigit();
                                          tomorrow = true;
                                          pastTomorrow = false;
                                          calender = false;
                                          twoDays = false;
                                          // showDateDialog(context);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "فردا",
                                          style: TextStyle(
                                              fontFamily: 'iransans',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ])
                          ])
                        : new Container(),
                    Divider(
                      color: Color(0xffeeeeee),
                      height: 15,
                      thickness: 1,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 40),
                          child: Text(
                            "توضیحات اضافه",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'iransans'),
                          ),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 1),
                            child: RoundedInputField(
                              hintText: "توضیحات",
                              onChanged: (value) {},
                              icon: Icons.description,
                              maxLine: 3,
                              controller: textDescriptionController,
                            ))),
                    SizedBox(height: size.height * 0.01),
                    RoundedButton(
                        text: "ثبت تماس",
                        press: () async {
                          Gregorian inProgressGregorian = Gregorian.fromJalali(
                              Jalali(
                                  int.parse(inProgressDate
                                      .toEnglishDigit()
                                      .split("/")[0]),
                                  int.parse(inProgressDate
                                      .toEnglishDigit()
                                      .split("/")[1]),
                                  int.parse(inProgressDate
                                      .toEnglishDigit()
                                      .split("/")[2])));
                          CallDataModel cm = CallDataModel(
                              id: "0",
                              userId: UserLoginDetail.userId,
                              customerId: snapshot.data!.id,
                              setDateTime: inProgressGregorian.toDateTime(),
                              creationDateTime: DateTime.now(),
                              status: callResultStatus.toString(),
                              doDateTime: DateTime.utc(1989),
                              enable: 1,
                              comment: textDescriptionController.text,
                              userName: UserLoginDetail.userName,
                              customerMobile: snapshot.data!.telephone,
                              customerName: snapshot.data!.name,
                              hashTags: textHashTagsController.text);
                          print(snapshot.data!.name);
                          CallDataLogic.insert(cm);
                          Navigator.pushNamedAndRemoveUntil(context, '/',(Route<dynamic> route) => false);
//                          Navigator.pushReplacement(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) {
//                                return MainPage(title: "Bezang");
//                              },
//                            ),
//                          );
                        })
                  ],
                ),
              ),
            );
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
