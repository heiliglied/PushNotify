import 'package:push_notify/views/calendar.dart';
import 'package:push_notify/views/mainpage.dart';
import 'package:push_notify/views/setnotify.dart';
import 'package:push_notify/views/splash.dart';
import 'package:flutter/widgets.dart';

class Routes {
  Routes._();
  static const String mainPage = "/";
  static const String set = "/set";
  static const String calendar = "/calendar";
  static const String splash = "/splash";

  static final routes = <String, WidgetBuilder>{
    mainPage: (BuildContext context) => MainPage(),
    set: (BuildContext context) => SetNotify(),
    calendar: (BuildContext context) => CalendarView(),
    splash: (BuildContext context) => SplashPage(),
  };
}