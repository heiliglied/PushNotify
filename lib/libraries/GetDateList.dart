import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:push_notify/database/database.dart';

class GetDateList {

  Future<List> defaultAlertCalender(BuildContext context) async {
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String startdate = year + '-01-01';
    String enddate = year + '-12-31';
    late String focusdate;
    late String firstday;
    late String lastday;
    late String castdate;
    late LinkedHashMap<DateTime, dynamic> events = new LinkedHashMap();

    await Provider.of<Database>(context as BuildContext, listen: false).selectFirstDate()?.then((value) => {
      value.forEach((element) {
        if(element.date == '' || element.date == null) {
          firstday = DateTime.parse(startdate).toString();
        } else {
          firstday = DateFormat('yyyy-MM-dd').format(element.date).toString();
        }
      })
    });

    await Provider.of<Database>(context as BuildContext, listen: false).selectLastDate()?.then((value) => {
      value.forEach((element) {
        if(element.date == '' || element.date == null) {
          lastday = DateTime.parse(enddate).toString();
          focusdate = DateTime.parse(enddate).toString();
        } else {
          focusdate = DateFormat('yyyy-MM-dd').format(DateTime(element.date.year, element.date.month, element.date.day));
          if(now.isAfter(element.date)) {
            lastday = DateFormat('yyyy-MM-dd').format(now).toString();
          } else {
            lastday = DateFormat('yyyy-MM-dd').format(element.date).toString();
          }
        }
      })
    });

    //lastday의 년 월 추출.
    castdate = focusdate.substring(0, 7) + '-01';
    //해당 추출한 날짜의 첫번째 일, 마지막 일을 계산해서 변수로 만듬.
    DateTime searchstart = DateTime.parse(castdate);
    DateTime searchend = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(searchstart.year, searchstart.month + 1, 0)));

    await Provider.of<Database>(context as BuildContext, listen: false).monthNotifyList(searchstart, searchend)?.then((value) => {
      value.forEach((element) {
        events.addAll(
          {
            DateTime(element.date.year, element.date.month, element.date.day): element
          }
        );
      })
    });

    return [
      focusdate,
      firstday,
      lastday,
      events
    ];
  }

  Future<List> alertListMonth(BuildContext context) async {
    return [

    ];
  }
}