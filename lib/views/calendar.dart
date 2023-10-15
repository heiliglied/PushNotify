import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/database/database.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:push_notify/views/partitions/EmptyPage.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarView();
}

class _CalendarView extends State<CalendarView> {
  String result = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: TableCalendar(
                    locale: 'ko-KR',
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.parse('2022-01-01'),
                    lastDay: DateTime.parse('2023-12-23'),
                    calendarFormat: CalendarFormat.month,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      titleTextFormatter: (date, locale) =>
                          DateFormat.yMMMMd(locale).format(date),
                      formatButtonVisible: false,
                      titleTextStyle: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue,
                      ),
                      headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
                      leftChevronIcon: const Icon(
                        Icons.arrow_left,
                        size: 40.0,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.arrow_right,
                        size: 40.0,
                      ),
                    ),
                )
            ),
            Expanded(
              child: Container(

              ),
            ),
          ],
        )
    );
  }
}
//https://velog.io/@1984/Flutter-toggle-button%EC%9D%84-%EB%84%A4%EB%B9%84%EA%B2%8C%EC%9D%B4%EC%85%98-%EB%B0%94%EC%B2%98%EB%9F%BC-%EB%A7%8C%EB%93%A4%EC%96%B4%EB%B3%B4%EC%9E%90