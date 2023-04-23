import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/database/database.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:push_notify/views/partitions/EmptyPage.dart';
import 'package:push_notify/views/modules/DetailBottomSheet.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget emptyPage = EmptyPage();
  int page = 1;
  int limit = 10;
  bool loading = false, allLoaded = false;

  List<NotificationData> list = [];

  fatchList() async {

  }

  Widget addlistView(List<NotificationData> notiList) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          DateTime date = notiList[index].date;
          String format = DateFormat('yyyy-MM-dd HH:mm').format(date);
          return GestureDetector(
              onTap: () => {DetailBottomSheet() ..showBottomSheet(context, notiList[index])},
              child: Card(
                  child: Container(
                      height: 80,
                      child: ListTile(
                        /*
                        leading: const Image(
                            image: AssetImage('assets/images/timetable.png')),

                         */
                        title: Text("지정시간 : $format"),
                        subtitle: Text("알림 : ${notiList[index].title}"),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      ))));
        },
        // separatorBuilder: (BuildContext context, int index) => const Divider(
        //       height: 1.0,
        //       color: Colors.blue,
        //     ),
        itemCount: notiList.length
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("푸시 알림"),
        ),
        drawer: BaseDrawer(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, Routes.set);
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
              child: StreamBuilder<List<NotificationData>?>(
                stream: Provider.of<Database>(context).watchNotNotifiedNotiPagination(page),
                builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      return Column(children: [
                        Expanded(
                          child: EmptyPage(),
                        )
                      ]);
                    }
                    return Column(children: [
                      Expanded(
                        child: addlistView(snapshot.data!),
                      )
                    ]);
                },
              ),
            )
          ],
        ));
  }
}