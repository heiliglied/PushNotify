import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:push_notify/data/Event.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

          ],
        ));
  }
}
