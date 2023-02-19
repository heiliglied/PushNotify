import 'package:push_notify/views/mainpage.dart';
import 'package:push_notify/views/setnotify.dart';
import 'package:flutter/widgets.dart';

class Routes {
  Routes._();
  static const String mainPage = "/";
  static const String set = "/set";

  static final routes = <String, WidgetBuilder>{
    mainPage: (BuildContext context) => MainPage(),
    set: (BuildContext context) => SetNotify(),
  };
}