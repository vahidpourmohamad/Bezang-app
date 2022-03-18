

import 'package:flutter/material.dart';

import 'component/body.dart';


// ignore: camel_case_types
class UserGroupScreen extends StatelessWidget {

  const UserGroupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Body(),
    );
  }
}