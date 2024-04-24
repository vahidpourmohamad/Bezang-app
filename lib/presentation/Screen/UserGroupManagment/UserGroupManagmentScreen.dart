import 'package:bestbuy/presentation/Screen/UserGroupManagment/component/joinGroupWidget.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class UserGroupManagmentScreen extends StatelessWidget {
  const UserGroupManagmentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JoinGroupWidget(),
    );
  }
}
