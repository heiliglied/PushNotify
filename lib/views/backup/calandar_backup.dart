import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime date;
  final Function callBack;
  CalendarWidget({required this.date, required this.callBack});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final _uniqueCalendarKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    print(widget.date); //날짜 제대로 받아옴.
    Map calendarSet = initializeCalendar(widget.date.year, widget.date.month, widget.date.day);
    return TableCalendar(
      key: _uniqueCalendarKey,
      locale: 'ko-KR',
      focusedDay: DateTime.parse(calendarSet['toMonth']),
      firstDay: DateTime.parse(calendarSet['preMonth']),
      lastDay: DateTime.parse(calendarSet['lastMonth']),
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

      onPageChanged: (focusDay) {
        widget.callBack(focusDay);
      },
    );
  }

  Map initializeCalendar(int year, int month, int day) {
    DateTime toDay = DateTime.now();
    DateTime getDay = DateTime(year, month, day);
    DateTime preDate = DateTime(year, month -1, 1);
    DateTime toLastDate = DateTime(year, month + 2, 0);
    String focusDay = '01';

    if(toDay == getDay) {
      focusDay = toDay.day.toString();
    }

    DateTime toFirstDate = DateTime(year, month, 1);

    String preMonth = preDate.year.toString() + '-' + preDate.month.toString().padLeft(2, '0') + '-01';
    String toMonth = getDay.year.toString() + '-' + getDay.month.toString().padLeft(2, '0') + '-' + focusDay.padLeft(2, '0');
    String lastMonth = toLastDate.year.toString() + '-' + toLastDate.month.toString().padLeft(2, '0') + '-' + toLastDate.day.toString();
    return {
      'preMonth': preMonth,
      'toMonth': toMonth,
      'lastMonth': lastMonth
    };
  }
}
