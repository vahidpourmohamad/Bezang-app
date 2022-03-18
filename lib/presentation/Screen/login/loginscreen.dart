
import 'package:flutter/material.dart';
import 'component/body.dart';

class LoginScreen extends StatelessWidget {
  final String mobile;

  const LoginScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(mobile: mobile),
    );
  }
}