import 'package:bestbuy/Data/dataprovider/UserDataLogic.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/UserGroup/component/background.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:bestbuy/presentation/widget/rounded_input_field.dart';
import 'package:flutter/material.dart';

class JoinGroupWidget extends StatefulWidget {
  const JoinGroupWidget({Key? key}) : super(key: key);

  @override
  State<JoinGroupWidget> createState() => _JoinGroupWidgetState();
}

class _JoinGroupWidgetState extends State<JoinGroupWidget> {
  final textMobileController = TextEditingController();
  String groupResualt = "";
  @override
  Widget build(BuildContext context) {
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
              alignment: Alignment.center,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
                child: Text(
                  "شما هیچ گروهی ندارید جهت تشکیل گروه لطفا شماره همراه یکی از اعضا را وارد کنید",
                  // Jalali.now().year.toString()+"/"+Jalali.now().month.toString()+"/"+Jalali.now().day.toString()+"امروز ",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'iransans'),
                ),
              ))),
      Align(
          alignment: Alignment.center,
          child: Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
              child: Column(children: [
                RoundedInputField(
                  hintText: "موبایل کاربر عضو",
                  onChanged: (value) {},
                  controller: textMobileController,
                  icon: Icons.account_box_rounded,
                ),
                RoundedButton(
                    text: "اضافه شدن به گروه",
                    color: Colors.green,
                    press: () async {
                      print(UserLoginDetail.userId);
                      groupResualt = await UserDataLogic.addToGroup(
                          textMobileController.text, UserLoginDetail.userId);
                    }),
                RoundedButton(
                    text: "حذف از گروه",
                    color: Colors.red,
                    press: () async {
                      print(UserLoginDetail.userId);
                      groupResualt = await UserDataLogic.deleteManagerMobile(
                          textMobileController.text, UserLoginDetail.userId);
                      setState(() {
                        groupResualt = groupResualt;
                      });
                    }),
                Text(
                  groupResualt,
                  // Jalali.now().year.toString()+"/"+Jalali.now().month.toString()+"/"+Jalali.now().day.toString()+"امروز ",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'iransans'),
                ),
              ]))),
    ]));
  }
}
