import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'avatarNetworkUnique.dart';

class UsersCard extends StatelessWidget {
  final Color prefixBadge;
  final Color suffixBadge;
  final Color iconColor;
  final Color suffixIconColor;
  final String title;
  final String date;
  final Color backgroundColor;
  final Color titleColor;
  final Color descriptionColor;
  final VoidCallback press;
  final String profileImage;

  const UsersCard({
    Key? key,
    required this.prefixBadge,
    required this.suffixBadge,
    required this.iconColor,
    required this.title,
    required this.backgroundColor,
    required this.suffixIconColor,
    required this.press,
    required this.date,
    required this.descriptionColor,
    required this.titleColor,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: this.press,
        child: Card(
          color: this.backgroundColor,
          shadowColor: Colors.green,
          margin: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 25.0,
                height: 80,
                color: this.prefixBadge,
              ),
              Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            this.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: this.titleColor,
                            ),
                          ),
                        ),
                        AvatarNetworkUnique(userName: profileImage),
                      ],
                    )),
              ),
              Container(
                width: 15.0,
                height: 80,
                color: this.prefixBadge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
