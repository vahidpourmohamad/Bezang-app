import 'package:bestbuy/Data/dataprovider/UserDataLogic.dart';
import 'package:bestbuy/Data/model/UserDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/homepage/backmainPage.dart';
import 'package:bestbuy/presentation/Screen/signup/signupscreen.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pushe_flutter/pushe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'background.dart';

class Body extends StatelessWidget {
  bool _pinTrue = false;
  bool _onTheProgress= false;
  final String mobile;

  Body({Key? key, required this.mobile}) : super(key: key);

  // final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/Login.png",
              height: size.height * 0.40,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "کد اعتبار سنجی",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'iransans'),
            ),
            SizedBox(height: size.height * 0.03),
            OTPTextField(
              length: 5,
              width: size.width * 0.8,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: MediaQuery.of(context).size.width / 7,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: TextStyle(fontSize: 17),
              onChanged: (pin) {
                print("Changed: " + pin);
              },
              onCompleted: (pin) {
                pin = pin.toEnglishDigit();
              //  print("Completed: " + UserLoginDetail.code);
               // ScaffoldMessenger.of(context)
              //      .showSnackBar(SnackBar(content: Text(pin)));
                if (pin == UserLoginDetail.code) {
                  _pinTrue = true;
                } else {
                  _pinTrue = false;
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "ورود",
              press: () async {
                if(_onTheProgress ==false) {
                  _onTheProgress = true;

                  if (_pinTrue == true) {
                    UserLoginDetail.mobile = mobile;
                    UserDataModel user =
                    await UserDataLogic.readOneUserByMobile(mobile);
                    if (user.id != "-1") {
                      Pushe.sendEvent("User reLogin");
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      prefs.setBool("introduction", true);
                      prefs.setString("mobile", UserLoginDetail.mobile);
                      prefs.setString("userName", user.name);
                      prefs.setString("userId", user.id);
                      prefs.setString("profilePhoto", user.profilePhoto);
                      prefs.setBool("paymentStatus", user.paymentStatus);

                      UserLoginDetail.introduction = true;
                      UserLoginDetail.userName = user.name;
                      UserLoginDetail.profilePhoto = user.profilePhoto;
                      UserLoginDetail.mobile = mobile;
                      UserLoginDetail.userId = user.id;
                      UserLoginDetail.paymentStatus = user.paymentStatus;

//613f356ac9ff54f03c48eb58
                      Navigator.pushNamedAndRemoveUntil(context, '/',(Route<dynamic> route) => false);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("کد اشتباه است")));
                  }
                  _onTheProgress=false;
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
