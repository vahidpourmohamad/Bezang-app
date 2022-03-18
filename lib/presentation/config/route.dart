import 'package:flutter/material.dart';
import 'package:bestbuy/presentation/Screen/homepage/mainPage.dart';


class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(title: "PFJ"),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
