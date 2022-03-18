import 'package:bestbuy/constant/color.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:flutter/material.dart';

class RoundedButtonWithSize extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final Size size;

  const RoundedButtonWithSize({
    Key? key,
    required this.text,
    required this.press,
    required this.size,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
              elevation: 5.0,
              shadowColor: LightColor.kPrimaryLightColor,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              backgroundColor: color),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'iransans',
                fontWeight: FontWeight.bold,
                color: textColor),
          ),
        ),
      ),
    );
  }
}
