import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/database/database.dart';



final DateTime _firstDay = DateTime.now().subtract(const Duration(days: 365));
final DateTime _lastDay = DateTime.now().add(const Duration(days: 365 * 2));


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class CalendarLib extends StatefulWidget {
  const CalendarLib({Key? key, required this.focusedDay, required this.kEvents, required this.notifyPageChange, required this.notifyFocusedChange}) : super(key: key);
  final DateTime focusedDay;
  final LinkedHashMap<DateTime, List<NotiData>> kEvents;
  final Function(DateTime) notifyPageChange;
  final Function(DateTime) notifyFocusedChange;

  @override
  State<StatefulWidget> createState() => _CalendarLibState();
}

class _CalendarLibState extends State<CalendarLib> {
  late final ValueNotifier<List<NotiData>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late LinkedHashMap<DateTime, List<NotiData>> _currentEvents;
  DateTime? _selectedDay;

  @override
  void initState() {
    _selectedDay = widget.focusedDay;
    _currentEvents = widget.kEvents;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<NotiData> _getEventsForDay(DateTime day) {
    return _currentEvents[day] ?? [];
  }

  @override
  void didUpdateWidget(covariant CalendarLib oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.kEvents != widget.kEvents) {
      setState(() {
        _currentEvents = widget.kEvents;
        print("didUpdateWidget : ${widget.kEvents}");
        if (_selectedDay != null) {
          _selectedEvents.value = _getEventsForDay(_selectedDay!);
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        TableCalendar(
          locale: 'ko-KR',
          firstDay: _firstDay,
          lastDay: _lastDay,
          focusedDay: widget.focusedDay,
          calendarFormat: _calendarFormat,
          availableCalendarFormats: const {
            CalendarFormat.month: '한달',
            CalendarFormat.twoWeeks: '2주',
          },
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
          eventLoader: (day) {
            return _getEventsForDay(day);
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              widget.notifyFocusedChange(focusedDay);
            });
            _selectedEvents.value = _getEventsForDay(selectedDay);
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (day) async {
            widget.notifyPageChange(day);
            print("onPageChanged >> day : $day");
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<NotiData>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ));
  }

}
