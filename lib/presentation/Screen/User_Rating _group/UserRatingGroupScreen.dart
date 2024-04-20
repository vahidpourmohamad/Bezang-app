import 'package:flutter/material.dart';

import 'component/body.dart';

// ignore: camel_case_types
class UserRatingGroupScreen extends StatelessWidget {
  final bool managerPermit;
  final String id;
  final String name;
  const UserRatingGroupScreen(
      {Key? key,
      required this.managerPermit,
      required this.id,
      required this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        managerPermit: managerPermit,
        id: id,
        name: name,
      ),
    );
  }
}
