import 'package:bestbuy/constant/color.dart';
import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedButton({
     Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),backgroundColor: color),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(fontFamily: 'iransans',fontWeight: FontWeight.bold , color: textColor),

          ),
        ),
      ),
    );
  }
}