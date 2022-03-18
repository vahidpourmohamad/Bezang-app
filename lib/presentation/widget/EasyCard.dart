import 'package:flutter/material.dart';

class EasyCard extends StatelessWidget {
  final Color prefixBadge;
  final Color suffixBadge;

  final Color iconColor;
  final Color suffixIconColor;
  final String title;
  final String description;
  final String date;
  final String mobile;
  final Color backgroundColor;
  final Color titleColor;
  final Color descriptionColor;
  final VoidCallback press;

  const EasyCard({
    Key? key,
    required this.prefixBadge,
    required this.suffixBadge,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.mobile,
    required this.suffixIconColor,
    required this.press,
    required this.date,
    required this.descriptionColor,
    required this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: this.press,
        child: Card(
          color: this.backgroundColor,
          margin: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 15.0,
                height: 60.0,
                color: this.prefixBadge,
              ),
              Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 10, top: 5, bottom: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                this.date,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: this.titleColor,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                this.mobile,
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 10.0,
                                    color: this.descriptionColor),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Container(
                              child: Text(
                                this.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: this.titleColor,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                this.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 10.0,
                                    color: this.descriptionColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              Container(
                width: 15.0,
                height: 60.0,
                color: this.suffixBadge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
