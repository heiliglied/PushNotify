import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:push_notify/views/partitions/EmptyList.dart';

import '../database/database.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<NotiData> list = [];

  Widget addlistView(List<NotiData> notiList) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          DateTime date = notiList[index].date;
          String format = DateFormat('yyyy-MM-dd HH:mm').format(date);
          return GestureDetector(
              onTap: () => {showBottomSheet(notiList[index])},
              child: Card(
                  child: Container(
                      height: 80,
                      child: ListTile(
                        leading: const Image(
                            image: AssetImage('assets/images/timetable.png')),
                        title: Text("지정시간 : $format"),
                        subtitle: Text("알림 : ${notiList[index].title}"),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      ))));
        },
        // separatorBuilder: (BuildContext context, int index) => const Divider(
        //       height: 1.0,
        //       color: Colors.blue,
        //     ),
        itemCount: notiList.length);
  }

  Future showBottomSheet(NotiData item) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.3, // 모달 높이 크기
            decoration: const BoxDecoration(
              color: Colors.white, // 모달 배경색
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0), // 모달 좌상단 라운딩 처리
                topRight: Radius.circular(0), // 모달 우상단 라운딩 처리
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                // height: double.infinity,
                // width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("알람 시간 : ${item.date}"),
                    Text("제목 : ${item.title}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("내용 : ${item.contents}"),
                  ],
                ),
              ), // 모달 내부 디자인 영역
            ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Get.find<MyDatabase>().watchNotNotifiedNoti().listen((listOfNoti) {
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
            Container(
              // color: Colors.grey,
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  (20 * 2) -
                  MediaQuery.of(context).viewPadding.top,
              // child: Column(children: [
              //   Expanded(
              //     child: list.isNotEmpty
              //         ? addlistView(list)
              //         : const EmptyList().build(context),
              //   )
              // ])
              child: StreamBuilder<List<NotiData>>(
                stream: Provider.of<MyDatabase>(context).watchNotNotifiedNoti(),
                builder: (context, snapshot) {
                  return Column(children: [
                    Expanded(
                        child: snapshot.hasData
                            ? addlistView(snapshot.data!)
                            : const EmptyList().build(context))
                  ]);
                },
              ),
            )
          ],
        ));
  }
}
