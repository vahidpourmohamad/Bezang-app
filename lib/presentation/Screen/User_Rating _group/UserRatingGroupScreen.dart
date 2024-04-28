import 'package:flutter/material.dart';

import 'component/body.dart';

// ignore: camel_case_types
class UserRatingGroupScreen extends StatelessWidget {
  final bool managerPermit;
  final String id;
  final String name;
  final String internal;
  const UserRatingGroupScreen(
      {Key? key,
      required this.managerPermit,
      required this.id,
      required this.name,
      required this.internal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        managerPermit: managerPermit,
        id: id,
        name: name,
        internal: internal,
      ),
    );
  }
}
