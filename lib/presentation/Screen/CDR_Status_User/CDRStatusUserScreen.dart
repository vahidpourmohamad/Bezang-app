import 'package:flutter/material.dart';

import 'component/body.dart';

// ignore: camel_case_types
class CDRStatusUserScreen extends StatelessWidget {
  final DateTime reportDay;
  final String name;
  final String internal;
  const CDRStatusUserScreen(
      {Key? key,
      required this.reportDay,
      required this.name,
      required this.internal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(name: name, reportDay: reportDay, internal: internal),
    );
  }
}
