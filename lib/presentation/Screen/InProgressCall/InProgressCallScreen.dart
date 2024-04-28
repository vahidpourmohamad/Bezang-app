import 'package:flutter/material.dart';

import 'component/body.dart';

// ignore: camel_case_types
class InProgressCallScreen extends StatelessWidget {
  final String name;
  final String id;
  const InProgressCallScreen({Key? key, required this.name, required this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(name: name, id: id),
    );
  }
}
