import 'package:flutter/material.dart';

import 'component/body.dart';

// ignore: camel_case_types
class TodayActionsListScreen extends StatelessWidget {
  final DateTime ReportDay;
  final String name;
  final String id;
  const TodayActionsListScreen(
      {Key? key, required this.ReportDay, required this.name, required this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(name: name, ReportDay: ReportDay, id: id),
    );
  }
}
