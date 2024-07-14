import 'package:push_notify/ui/page/calendar/calendarpage.dart';
import 'package:push_notify/ui/page/detail/detailpage.dart';
import 'package:push_notify/ui/page/mainpage.dart';
import 'package:flutter/widgets.dart';

class Routes {
  Routes._();

  static const String mainPage = "/";
  static const String detailPage = "/detail";
  static const String calendarPage = "/calendar";

  static final routes = <String, WidgetBuilder>{
    mainPage: (BuildContext context) => const MainPage(),
    detailPage: (BuildContext context) => const DetailPage(),
    calendarPage: (BuildContext context) => const CalendarPage()
  };
}
