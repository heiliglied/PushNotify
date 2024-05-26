import 'package:push_notify/ui/page/calendarpage.dart';
import 'package:push_notify/ui/page/detailpage.dart';
import 'package:push_notify/ui/page/mainpage.dart';
import 'package:flutter/widgets.dart';

class Routes {
  Routes._();

  static const String mainPage = "/";
  static const String detailPage = "/detail";
  static const String calendarPage = "/calendar";

  static final routes = <String, WidgetBuilder>{
    mainPage: (BuildContext context) => MainPage(),
    detailPage: (BuildContext context) => DetailPage(),
    calendarPage: (BuildContext context) => CalendarPage()
  };
}
