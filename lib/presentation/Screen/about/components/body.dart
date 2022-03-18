import 'package:flutter/material.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(children: [
                Align(
                  alignment: Alignment.center,
                  child:Image.asset(
                    "assets/images/logoNormalAzhang.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  ),
                SizedBox( width: 200.0,
                    height: MediaQuery.of(context).size.width*0.15),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "ما چه افرادی هستیم",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'iransans'),
                  ),
                ),
                SizedBox( width: 200.0,
                  height: MediaQuery.of(context).size.width*0.15),
                Text(
                 "گروه مشاوره بازاریابی آژنگ تولید کننده و صاحب امتیاز اپلیکیشن بزنگ در سال 1395 تاسیس و تا به امروز به بیش از 100 مجموعه  اقتصادی مشاوره تخصصی در زمینه فروش ارائه کرده است . حوزه فعالیت این گروه بیشتر بر آموزش تمرکز دارد . این گروه به عنوان گروهی پیشرو از مرکز بازاریابی بین الملل پردیس ثبت شده است . اطلاعات تماس 05135018528-09151101602 آدرس: مشهد- برج کاسپین مد واحد 248",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: 'iransans'),
                ),

              ]),
            ))));
  }
}
