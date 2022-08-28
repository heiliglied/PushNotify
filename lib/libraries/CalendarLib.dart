import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:push_notify/data/Event.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../routes.dart';


final DateTime _firstDay = DateTime.now().subtract(Duration(days: 365));
final DateTime _lastDay = DateTime.now().add(Duration(days:365 * 2));
final DateTime _today = DateTime.now();

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(_firstDay.year, _firstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    _today: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });


class CalendarLib extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarLibState();
}

class _CalendarLibState extends State<CalendarLib> {

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day){
    return kEvents[day] ?? [];
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("타이틀"),
        ),
        drawer: BaseDrawer(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, Routes.detailPage);
            },
            label: Text("작성하기")),
        body: Column(
          children: [
            TableCalendar(
              locale: 'ko-KR',
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,

              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: '한달',
                CalendarFormat.twoWeeks: '2주',
              },

              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },

            )
          ],
        ));
  }
}
