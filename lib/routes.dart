import 'package:push_notify/views/alertlist.dart';
import 'package:push_notify/views/mainpage.dart';
import 'package:push_notify/views/setnotify.dart';
import 'package:push_notify/views/splash.dart';
import 'package:flutter/widgets.dart';

class Routes {
  Routes._();
  static const String mainPage = "/";
  static const String set = "/set";
  static const String list = "/list";
  static const String splash = "/splash";

  static final routes = <String, WidgetBuilder>{
    mainPage: (BuildContext context) => MainPage(),
    set: (BuildContext context) => SetNotify(),
    list: (BuildContext context) => AlertList(),
    splash: (BuildContext context) => SplashPage(),
  };
}