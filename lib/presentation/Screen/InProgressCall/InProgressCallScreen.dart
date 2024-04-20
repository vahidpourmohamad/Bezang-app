import 'package:flutter/material.dart';

import 'component/body.dart';

// ignore: camel_case_types
class InProgressCallScreen extends StatelessWidget {
  final String name;
  const InProgressCallScreen({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(name: name),
    );
  }
}
