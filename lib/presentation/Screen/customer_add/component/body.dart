import 'package:bestbuy/Data/dataprovider/CustomerDataLogic.dart';
import 'package:bestbuy/Data/model/CustomerDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/Screen/Customer_Call/CustomerCallScreen.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:bestbuy/presentation/widget/rounded_drop_dwon.dart';
import 'package:bestbuy/presentation/widget/rounded_input_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';


import 'background.dart';

class Body extends StatelessWidget {
  Future<List<dynamic>> getJob() async {
    try {
      var response =
          await Dio().get('http://pouncing-denim-chip.glitch.me/getjob');

      List<dynamic> jsonmap = response.data; //jsonDecode();
      // = jsonDecode(response.data);
      print(jsonmap[0]["name"]);
      return (jsonmap);
    } catch (e) {
      print(e);
      throw '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: getJob(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            Size size = MediaQuery.of(context).size;
            final textNameController = TextEditingController();
            final textMobileController = TextEditingController();
            final textBusinessController = TextEditingController();
            final textAddressController = TextEditingController();
            final textJobController = TextEditingController();
            final textDescriptionController = TextEditingController();
            String jobSelected = "عمومی";
            var job = <String>[]; // List<String> job= List<String>();
            for (var i = 0; i < snapshot.data!.length; i++) {
              job.add(snapshot.data![i]["name"]);
            }

            //List<String> job =
            //snapshot.data!.entries.map( (entry) => entry.key).toList();
            // String rawJson = '{"name":"Mary","age":30}';
            // final String rawJson = getJob();
            //print(rawJson);
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
                      hintText: "نام و نام خانوادگی",
                      onChanged: (value) {},
                      controller: textNameController,
                    ),
                    RoundedInputField(
                      hintText: "تلفن همراه",
                      onChanged: (value) {},
                      icon: Icons.phone,
                      controller: textMobileController,
                      keyboardType: TextInputType.number,
                    ),
                    RoundedInputField(
                      hintText: "نام کسب و کار",
                      onChanged: (value) {},
                      icon: Icons.business,
                      controller: textBusinessController,
                    ),
                    RoundedInputField(
                      hintText: "شهر",
                      onChanged: (value) {},
                      icon: Icons.add_location,
                      controller: textAddressController,
                    ),
                    RoundedDropDown(
                      hintText: "رسته شغلی",
                      onChanged: (value) {
//                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                          content: Text(value),
//                        ));
                        jobSelected = value;
                      },
                      icon: Icons.build_sharp,
                      controller: textJobController,
                      dValues: job,
                      size: Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.07),//snapshot.data!.cast<String>(),
                    ),

                    RoundedInputField(
                      hintText: "توضیحات",
                      onChanged: (value) {},
                      icon: Icons.description,
                      maxLine: 2,
                      controller: textDescriptionController,
                    ),

//                  final textNameController = TextEditingController();
//                final textFamilyController = TextEditingController();
//            final textTelController = TextEditingController();
//            final textAddressController = TextEditingController();
//            final textDescriptionController = TextEditingController();
                    RoundedButton(
                      text: "ثبت مشتری جدید",
                      press: () async {
                        CustomerDataModel customer = CustomerDataModel(
                            id: "0",
                            name: textNameController.text,
                            company: textBusinessController.text,
                            telephone: textMobileController.text.toEnglishDigit(),
                            creationDate: DateTime.now(),
                            enable: true,
                            bank: UserLoginDetail.userId,
                            creationUserList: [UserLoginDetail.userId],
                            workgroup: jobSelected,
                            comment: textDescriptionController.text,
                            enableComment: "Enable By Default");
                        CustomerDataLogic.insert(customer);
                       // Navigator.pop(context);
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                           builder: (context) {
                               return CustomerCallScreen(mobile: textMobileController.text,userCreated:  true);

                            },
                          ),
                        );
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
                        // jobReader.readJob();
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
          } else {
            if (snapshot.hasError) {
              print("error");
            }

            return CircularProgressIndicator();
          }
        });
  }
}
