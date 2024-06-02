import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:push_notify/data/database/database.dart';
import 'package:push_notify/service/MyService.dart';
import 'package:push_notify/ui/common/BaseDrawer.dart';
import 'package:push_notify/ui/libraries/CalendarLib.dart';
import 'package:push_notify/ui/page/calendar/CalendarViewModel.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final viewModel = locator<CalendarViewModel>();

  void _changePage(DateTime newFocusedDay) {
    viewModel.updateFocusdDay(newFocusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("타이틀"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: BackButtonIcon(),
          ),
        ),
        endDrawer: BaseDrawer(),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          children: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('달력보기', style: TextStyle(fontSize: 18))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('목록보기', style: TextStyle(fontSize: 18))),
          ],
          isSelected: viewModel.isSelected,
          onPressed: viewModel.toggleSelect,
        ),
        StreamBuilder(
            stream: viewModel.notiDataStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                LinkedHashMap<DateTime, List<NotiData>> kEvents =
                    LinkedHashMap<DateTime, List<NotiData>>();
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData) {
                  Map<DateTime, List<NotiData>> map = groupBy(
                      snapshot.data as List<NotiData>,
                      (NotiData data) => DateTime(
                          data.date.year, data.date.month, data.date.day));
                  kEvents = LinkedHashMap<DateTime, List<NotiData>>(
                    equals: isSameDay,
                    hashCode: getHashCode,
                  )..addAll(map);
                  print("stream builder >>>>> $kEvents");
                }
                return CalendarLib(
                    focusedDay: viewModel.focusedDay,
                    kEvents: kEvents,
                    notifyPageChange: _changePage);
              }
            })
      ],
    );
  }
}
