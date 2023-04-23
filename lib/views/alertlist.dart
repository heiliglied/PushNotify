import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/database/database.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:push_notify/views/partitions/EmptyPage.dart';

class AlertList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AlertList();
}

class _AlertList extends State<AlertList> {
  @override
  void initState() {
    super.initState();
  }

  List<NotificationData> list = [];

  Widget addlistView(List<NotificationData> notiList) {
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

  Future showBottomSheet(NotificationData item) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3, // 모달 높이 크기
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("알림 내역"),
        ),
        drawer: BaseDrawer(),
        body: Column(
          children: [
            Container(
              // color: Colors.grey,
              width: MediaQuery.of(context).size.width,
              height: 70.0,
              child: Column(children: [
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () => {

                        },
                        child: Text("달력보기"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                        )
                    )
                  ]
                )
              ])
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 80,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          // child: Column(children: [
                          //   Expanded(
                          //     child: list.isNotEmpty
                          //         ? addlistView(list)
                          //         : const EmptyList().build(context),
                          //   )
                          // ])
                          child: StreamBuilder<List<NotificationData>>(
                            stream: Provider.of<Database>(context).watchNotNotifiedNoti(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData) {
                                return Column(children: [
                                  Expanded(
                                    child: addlistView(snapshot.data!),
                                  )
                                ]);
                              }
                              return Column(children: [
                                Expanded(
                                  child: EmptyPage(),
                                )
                              ]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
        )
    );
  }
}