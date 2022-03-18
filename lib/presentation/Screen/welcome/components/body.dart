import 'dart:math';

import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/constant/color.dart';
import 'package:bestbuy/presentation/Screen/login/loginscreen.dart';
import 'package:bestbuy/presentation/Screen/privacyRight/privacy_screen.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:bestbuy/presentation/widget/rounded_input_field.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'background.dart';

class Body extends StatelessWidget {

  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final txtMobilecontroller = TextEditingController();
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logotop.jpg',
              height: size.height * 0.1,
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "به پلتفرم بزنگ خوش آمدید",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'iransans'),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              'assets/images/chat.png',
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedInputField(
              hintText: " تلفن همراه",
              onChanged: (value) {},
              controller: txtMobilecontroller,
              keyboardType: TextInputType.number,
            ),
            GestureDetector(
                child: Text("متن قانون حریم خصوصی", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                onTap: () {   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PrivacyScreen();
                    },
                  ),
                );
                }
            ),
            RoundedButton(
              text: "تایید متن حریم خصوصی و ارسال کد تایید",
              color: kPrimaryColor,
              textColor: Colors.white,
              press: () async {
                //////
                String temp=txtMobilecontroller.text.toEnglishDigit();

                if(temp.isNumeric()==true) {
                  Random _rnd = Random();
                  int _code = _rnd.nextInt(88888) + 11111;
                  UserLoginDetail.code = _code.toString();
                  Dio().options.contentType = Headers.jsonContentType;
                  await Dio()
                      .get('https://raygansms.com/SendMessageWithCode.ashx',
                      queryParameters: {
                        'UserName': "09151101602",
                        'Password': "3607412",
                        'Mobile': temp,
                        'Message': "کد ثبت نام نرم افزار بزنگ : " +
                            UserLoginDetail.code
                      });

                  //////
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen(mobile: temp);
                      },
                    ),
                  );
                }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("فقط عدد وارد کنید")));
                  }
              },
            ),
          ],
        ),
      ),
    );
  }
}
