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
  Widget emptyPage = EmptyPage();
  int page = 0;
  int limit = 10;
  var stream;
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          page++;
          stream = newStream();
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stream = newStream();
  }

  Stream<List<NotificationData>>? newStream() {
    return Provider.of<Database>(context, listen: false).getNotNotifiedNotiPaginationStream(page, limit);
  }

  Widget addlistView(List<NotificationData> notiList) {
    return ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
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
            Expanded(
              child: Container(
                // color: Colors.grey,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<List<NotificationData>>(
                  stream: stream,
                  builder: (context, snapshot) {
                    return Column(children: [
                      Expanded(
                          child: snapshot.hasData
                              ? addlistView(snapshot.data!)
                              : emptyPage
                      )
                    ]);
                  },
                ),
              ),
              flex: 9,
            )
          ],
        )
    );
  }
}
