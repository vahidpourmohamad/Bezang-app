import 'package:bestbuy/constant/color.dart';
import 'package:bestbuy/presentation/widget/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final int maxLine;
  final double wordSpace;
final TextInputType keyboardType;
  const RoundedInputField(
      {Key? key,
      required this.hintText,
      this.icon = Icons.accessibility,
      required this.onChanged,
      required this.controller,
        this.keyboardType=TextInputType.text,
      this.maxLine = 1,this.wordSpace=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasIcon= false;
    if(icon==Icons.accessibility)
      {
        hasIcon=false;
      }
    else
      {
        hasIcon=true;
      }
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        textAlign: TextAlign.right,
        cursorColor: kPrimaryColor,
        maxLines: maxLine,
        controller: controller,
        keyboardType: keyboardType,
        decoration: hasIcon? InputDecoration(
          icon: Icon(
             icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ): InputDecoration(
          hintText: hintText,
          border: InputBorder.none,

          
        ),
        style: TextStyle(
          wordSpacing: wordSpace
        ),
      ),
    );
  }
}
