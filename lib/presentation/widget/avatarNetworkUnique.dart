import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 class AvatarNetworkUnique extends StatelessWidget {
   final String userName;


  const AvatarNetworkUnique({Key? key,required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return(
    SvgPicture.network(
      "https://api.multiavatar.com/" +userName,
      semanticsLabel: 'UserLoginDetail.userName',
      height: MediaQuery.of(context).size.height * 0.075,
      placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(00.0),
          height: MediaQuery.of(context).size.height * 0.075,
          child: const CircularProgressIndicator()),
    ));
  }

 }