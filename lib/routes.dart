import 'package:push_notify/views/detailpage.dart';
import 'package:push_notify/views/mainpage.dart';
import 'package:flutter/widgets.dart';

class Routes {
  Routes._();

  static const String mainPage = "/";
  static const String detailPage = "/detail";

  static final routes = <String, WidgetBuilder>{
    mainPage: (BuildContext context) => MainPage(),
    detailPage: (BuildContext context) => DetailPage()
  };
}
