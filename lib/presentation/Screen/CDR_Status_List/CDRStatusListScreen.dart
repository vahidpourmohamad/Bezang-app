

import 'package:flutter/material.dart';

import 'component/body.dart';


// ignore: camel_case_types
class CDRStatusListScreen extends StatelessWidget {
  final String mobile;
  final String name;
  const CDRStatusListScreen({Key? key,required this.mobile,required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Body(name:name,mobile:mobile,),
    );
  }
}