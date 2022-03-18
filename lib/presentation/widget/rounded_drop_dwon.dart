import 'package:bestbuy/constant/color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class RoundedDropDown extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged onChanged;
  final TextEditingController controller;
  final List<String> dValues;
  final Size size;

  const RoundedDropDown(
      {Key? key,
      required this.hintText,
      this.icon = Icons.person,
      required this.onChanged,
      required this.controller,
      required this.dValues,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        height: size.height,
        margin: EdgeInsets.symmetric(vertical: 4),
        child: DecoratedBox(
            decoration: ShapeDecoration(
              color: kPrimaryLightColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 2.0,
                    style: BorderStyle.solid,
                    color: kPrimaryLightColor),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownSearch<String>(
                  mode: Mode.BOTTOM_SHEET,
                  // showSelectedItem: true,
                  items: dValues,
                  showSearchBox: true,
                  showClearButton: true,
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: onChanged,
                  dropdownSearchDecoration: InputDecoration(

                    hintText: "انتخاب کنید",
                    labelText: hintText,
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    border: OutlineInputBorder(),
                  ) ,
                ),
//            DropdownButtonFormField<String>(
//              value: dValues[0],
//              elevation: 0,
//              onChanged:onChanged,
//              icon: Icon(
//                icon,
//                color: kPrimaryColor,
//              ),
//
//             // underline: SizedBox(),
//              items: dValues
//                  .map<DropdownMenuItem<String>>((String value) {
//                return DropdownMenuItem<String>(
//                  value: value,
//                  child: Text(value,
//                      textAlign: TextAlign.left
//                  ),
//                );
//              }).toList(),
//
//            ),
              ),
            )));
  }
}
