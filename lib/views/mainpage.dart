import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/database/database.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:push_notify/views/partitions/EmptyPage.dart';
import 'package:push_notify/views/modules/DetailBottomSheet.dart';
import 'package:push_notify/libraries/CustomRouteObserver.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget emptyPage = EmptyPage();
  int page = 0;
  int limit = 8;
  bool loading = false, allLoaded = false;
  final List<NotificationData> list = [];
  final ScrollController _scrollController = new ScrollController();

  var navStack = CommonRouteObserver.navStack;

  @override
  void initState() {
    super.initState();
    fatchList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          page++;
          fatchList();
        });
      }
    });
  }

  fatchList() async {
    if(allLoaded) {
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(Duration(microseconds: 500));
    await Provider.of<Database>(context, listen: false).getNotNotifiedNotiPagination(page, limit)?.then((value) =>
    {
      value.forEach((element) {
        list.add(element);
      })
    });

    setState(() {
      loading = false;
      allLoaded = list.isEmpty;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget addlistView(List<dynamic> notiList) {
    return ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          DateTime date = notiList[index].date;
          String format = DateFormat('yyyy-MM-dd HH:mm').format(date);
          return GestureDetector(
              onTap: () async => {
                await DetailBottomSheet() ..showBottomSheet(context, notiList[index], index).then((value) => setState(() {
                  if(value != null) {
                    notiList.removeAt(value);
                  }
                }))
              },
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
                      )
                  )
              )
          );
        },
        itemCount: notiList.length
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text("푸시 알림"),
          ),
          drawer: BaseDrawer(),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.set).then((value) => setState((){
                  Navigator.pushNamedAndRemoveUntil(context, Routes.mainPage, (r) => false, arguments: {"title": "홈"});
                }));
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
                  child: list.isEmpty ? emptyPage : addlistView(list),
                ),
                flex: 9,
              )
            ],
          )
      ),
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('종료 하시겠습니까?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        //print(navStack[1].name);
        return shouldPop!;
      },
    );
  }
}
