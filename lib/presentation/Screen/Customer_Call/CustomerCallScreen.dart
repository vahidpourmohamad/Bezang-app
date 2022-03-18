import 'package:bestbuy/Data/dataprovider/CustomerDataLogic.dart';
import 'package:bestbuy/Data/model/CustomerDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';
import 'package:flutter/material.dart';

import 'component/body.dart';

// ignore: camel_case_types
class CustomerCallScreen extends StatelessWidget {
  final String mobile;
  final bool userCreated;

  const CustomerCallScreen({Key? key, required this.mobile,required this.userCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<CustomerDataModel>(
            future: CustomerDataLogic.readOneCustomerByBankUserCall(
                mobile, UserLoginDetail.userId,userCreated),
            builder: (context, AsyncSnapshot<CustomerDataModel> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.telephone == "-1") {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "متسفانه بانک خالی است",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontFamily: 'iransans'),
                        )),
                    RoundedButton(
                        text: "برگشت",
                        press: () {
                          Navigator.pop(context);
                        })
                  ]);
                } else {
                  return (Body(mobile: snapshot.data!.telephone,userCreated: userCreated,));
                }
              } else {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              }
            }));
  }
}
