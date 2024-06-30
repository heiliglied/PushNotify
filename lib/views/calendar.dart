import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:push_notify/database/database.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:push_notify/libraries/GetDateList.dart';
import 'package:push_notify/libraries/CalendarWidget.dart';
import 'package:collection/collection.dart';

class CalendarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarView();
}

class _CalendarView extends State<CalendarView> {
  @override
  void initState() {
    super.initState();
  }

  final _uniqueCalendarKey = UniqueKey();
  DateTime now = DateTime.now();
  late Widget calendarWidget;

  @override
  Widget build(BuildContext context) {
    /*
    Map calendarSet = initializeCalendar(2024, now.month);
    String toDate = now.day.toString().padLeft(2, '0');
    String calendarDate = now.year.toString() + '-' + now.month.toString();
    Future<List> calendar = callCalendar(context);
    */
    calendarWidget = CalendarWidget(date: DateTime.now(), callBack: callBack);

    return Scaffold(
        key: _uniqueCalendarKey,
        appBar: AppBar(
          title: Text("알림 내역"),
        ),
        drawer: BaseDrawer(),
        body: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.lightBlue,
                        width: 2,
                      )
                  )
              ),
              child: ToggleButtons(
                borderWidth: 0,
                borderColor: Colors.white,
                selectedColor: Colors.black,
                isSelected: [true, false],
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('달력보기', style: TextStyle(fontSize: 18))),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('목록보기', style: TextStyle(fontSize: 18))),
                ],
                //toggle button은 setState없이는 true, false 확인 못함.
                onPressed: (index) {
                  setState(() {
                    if (index == 0) {
                      Navigator.pushNamed(context, '/calendar');
                    } else if (index == 1) {
                      Navigator.pushNamed(context, '/');
                    }
                  });
                },
              )
            ),
            Container(
              child: calendarWidget //widget 반환
            ),
            Expanded(
              child: Container(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      //calendarWidget = CalendarWidget(date: DateTime(2024, 3, 1), callBack(null));
                      //print('aa!');
                    });
                  },
                  child: Text("버튼!"),
                ),
              ),
            ),
          ],
        )
    );
  }

  callBack(DateTime? change) {
    if(change != null) {
      //print(DateTime(change.year, change.month, change.day));
      setState(() {
        //로딩 시 focus가 초기 데이터에서 변하지 않는 문제 해결 필요.
        //※ 콜백 함수에 파라미터를 넘기면 람다로 해석되어 재귀 되어버림.
        calendarWidget = new CalendarWidget(date: DateTime(change.year, change.month, change.day), callBack: callBack);
      });
    }
  }

  Future<List> callCalendar(BuildContext context) async {
    List defaultCalendar = await GetDateList().defaultAlertCalender(context) as List;
    return [
      defaultCalendar[0],
      defaultCalendar[1],
      defaultCalendar[2],
      defaultCalendar[3],
    ];
  }
}
