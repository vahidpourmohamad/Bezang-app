import 'package:flutter/material.dart';
import 'package:bestbuy/presentation/screen/homepage/mainPage.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(title: "bezang",),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
