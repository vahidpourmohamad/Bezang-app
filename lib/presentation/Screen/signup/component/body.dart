import 'package:bestbuy/Data/dataprovider/UserDataLogic.dart';
import 'package:bestbuy/Data/model/UserDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/constant/color.dart';

import 'package:bestbuy/presentation/Screen/homepage/mainPage.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:bestbuy/presentation/widget/rounded_input_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pushe_flutter/pushe.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'background.dart';

enum gender { man, woman }

class Body extends StatefulWidget {
  //final  provider _character = provider.salesman;

  const Body({Key? key}) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
      bool? _character= true;
  loadSetting(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("introduction", true);
    UserLoginDetail.introduction = true;
    UserLoginDetail.userName = username;
    prefs.setString("mobile", UserLoginDetail.mobile);
    prefs.setString("userName", username);
    //prefs.setString("version", UserLoginDetail.version);
    prefs.setString("profilePhoto", username);
    UserLoginDetail.profilePhoto = username;
  }

  loadUserId(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserDataModel user = await UserDataLogic.readOneUserByName(username);
    prefs.setString("userId", user.id);
    print(user.id);
    UserLoginDetail.userId = user.id;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final textNameController = TextEditingController();
    final textFamilyController = TextEditingController();
    final textTelController = TextEditingController();
    final textAddressController = TextEditingController();


    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                alignment: Alignment.center,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Row(children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: const Text('آقا',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'iransans')),
                    leading: Radio<bool>(
                        value: true,
                        groupValue: _character,
                        onChanged: (value) {
                          setState(() {
                            _character = value;
                          });
                        }),
                  )),
                  Expanded(
                      child: ListTile(
                    title: const Text('بانو',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'iransans')),
                    leading: Radio<bool>(
                        value: false,
                        groupValue: _character,
                        onChanged: (value) {
                          setState(() {
                            _character = value;
                          });
                        }),
                  ))
                ])),
            RoundedInputField(
              hintText: "نام کامل",
              onChanged: (value) {},
              controller: textNameController,
              icon: Icons.account_box_rounded,
            ),
            RoundedInputField(
              hintText: "شرکت",
              onChanged: (value) {},
              icon: Icons.house,
              controller: textFamilyController,
            ),
            RoundedInputField(
              hintText: "سن",
              onChanged: (value) {},
              icon: Icons.access_alarm_rounded,
              controller: textTelController,
            ),
            RoundedInputField(
              hintText: "رسته شغلی شما مثلا بیمه",
              onChanged: (value) {},
              icon: Icons.work,
              controller: textAddressController,
            ),

            RoundedButton(
              text: "ثبت نام",
              press: () {
                loadSetting(textNameController.text);
                UserLoginDetail.introduction = true;
                UserLoginDetail.userName = textNameController.text;
                //prefs.setString("version", UserLoginDetail.version);
                UserLoginDetail.profilePhoto = textNameController.text;
                UserLoginDetail.paymentStatus = false;
                /////
                UserDataModel user = UserDataModel(
                    id: "",
                    name: textNameController.text,
                    company: textFamilyController.text,
                    telephone: UserLoginDetail.mobile,
                    creationDate: DateTime.now(),
                    enable: true,
                    mangerId: "",
                    paymentStatus: false,
                    applicationVersion: UserLoginDetail.version,
                    gender: _character ?? true,
                    age: 25,
                    workScope: textAddressController.text,
                    comment: "",
                    enableComment: "Enable by default",
                    profilePhoto: textNameController.text);
                UserDataLogic.insert(user);
                Pushe.sendEvent("User Inserted");
                loadUserId(textNameController.text);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return MainPage(title: "Bezang");
                  },
                ), (Route<dynamic> route) => false);
//                showDialog(
//                  context: context,
//                  builder: (context) {
//                    return AlertDialog(
//                      // Retrieve the text the user has entered by using the
//                      // TextEditingController.
//                      content: Text(textNameController.text),
//                    );
//                  },
//                );
              },
            ),

            SizedBox(height: size.height * 0.01),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                SocalIcon(
//                  iconSrc: "assets/icons/facebook.svg",
//                  press: () {},
//                ),
//                SocalIcon(
//                  iconSrc: "assets/icons/twitter.svg",
//                  press: () {},
//                ),
//                SocalIcon(
//                  iconSrc: "assets/icons/google-plus.svg",
//                  press: () {},
//                ),
//              ],
//            )
          ],
        ),
      ),
    );
  }
}
