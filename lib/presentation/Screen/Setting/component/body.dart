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
  final textNameController = TextEditingController();
  final textFamilyController = TextEditingController();
  final textTelController = TextEditingController();
  final textAddressController = TextEditingController();
  final textFamilyManagerNameController = TextEditingController();
  final textApiController = TextEditingController();
  final textInternalController = TextEditingController();
  loadSetting(String username) async {
    UserDataModel user =
        await UserDataLogic.readOneUserByName(UserLoginDetail.userName);
    UserDataModel managerUser;
    if (user.mangerId == "") {
      textFamilyManagerNameController.text = "";
    } else {
      managerUser = await UserDataLogic.readOneUserById(user.mangerId);
      textFamilyManagerNameController.text = managerUser.name;
    }

    textNameController.text = user.name;
    textFamilyController.text = user.company;
    textTelController.text = user.telephone;
    textAddressController.text = user.workScope;
    textApiController.text = user.comment;
    textInternalController.text = user.age.toString();
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
    loadSetting(UserLoginDetail.userName);
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
              hintText: "داخلی",
              onChanged: (value) {},
              icon: Icons.access_alarm_rounded,
              controller: textInternalController,
            ),
            RoundedInputField(
              hintText: "API",
              onChanged: (value) {},
              icon: Icons.access_alarm_rounded,
              controller: textApiController,
            ),
            RoundedInputField(
              hintText: "رسته شغلی شما مثلا بیمه",
              onChanged: (value) {},
              icon: Icons.work,
              controller: textAddressController,
            ),
            RoundedButton(
              text: "حذف از گروه کاری",
              press: () {
                UserDataLogic.deleteManager(UserLoginDetail.userId);

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return MainPage(title: "Bezang");
                  },
                ), (Route<dynamic> route) => false);
//
              },
            ),
            RoundedButton(
              text: "ثبت تغییرات",
              press: () {
                loadSetting(textNameController.text);
                UserLoginDetail.APICode = textApiController.text;
                UserLoginDetail.internal = textInternalController.text;

                //prefs.setString("version", UserLoginDetail.version);

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
                    gender: true,
                    age: int.parse(UserLoginDetail.internal),
                    workScope: textAddressController.text,
                    comment: textApiController.text,
                    enableComment: "Enable by default",
                    profilePhoto: textNameController.text);
                UserDataLogic.update(user);

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return MainPage(title: "Bezang");
                  },
                ), (Route<dynamic> route) => false);
//
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
