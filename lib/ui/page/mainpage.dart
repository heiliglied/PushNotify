import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/ui/page/partitions/BaseDrawer.dart';
import 'package:push_notify/ui/page/partitions/EmptyList.dart';

import '../../data/database/database.dart';
import '../../service/MyService.dart';
import '../route/CommonRouteObserver.dart';
import 'MainViewModel.dart';


class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  final viewModel = locator<MainViewModel>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!viewModel.allLoaded) {
          viewModel.updatePage;
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var list = AppNavObserver.navStack;
    list.forEach((element) {
      print("${element.name}>");
    });

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text("타이틀"),
            ),
            endDrawer: BaseDrawer(),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.detailPage);
                },
                label: Text("작성하기")),
            body: _buildBody(context)),
        onWillPop: () async {
          return false;
        });
  }

  Widget _buildListView(List<NotiData> notiList) {
    return ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
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
        itemCount: notiList.length);
  }

  Future showBottomSheet(NotiData item) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.4, // 모달 높이 크기
            decoration: const BoxDecoration(
              color: Colors.white, // 모달 배경색
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0), // 모달 좌상단 라운딩 처리
                topRight: Radius.circular(0), // 모달 우상단 라운딩 처리
              ),
            ),
            child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.lightBlue,
                        width: 2,
                      ))),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text("지정시간", style: TextStyle(fontSize: 18)),
                          ),
                          Expanded(
                              child: Text(
                                  "${DateFormat('yyyy-MM-dd HH:mm').format(item.date)}",
                                  style: TextStyle(fontSize: 18)))
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.lightBlue,
                        width: 2,
                      ))),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text("제목", style: TextStyle(fontSize: 18)),
                          ),
                          Expanded(
                              child: Text("${item.title}",
                                  style: TextStyle(fontSize: 18)))
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            child: Text("내용", style: TextStyle(fontSize: 18)),
                          ),
                          Expanded(
                              child: Text("${item.contents}",
                                  style: TextStyle(fontSize: 18)))
                        ],
                      ),
                    ))),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                          color: Colors.lightBlue,
                          width: 2,
                        ))),
                        height: 50,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                ElevatedButton(
                                    child: Text("알림 변경"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.lightBlueAccent),
                                    onPressed: () async {
                                      viewModel
                                          .getNoti(item.id)
                                          .then((value) => {
                                                Navigator.pop(context),
                                                Navigator.pushNamed(
                                                    context, Routes.detailPage,
                                                    arguments: value),
                                                // showToast("$value"),
                                              })
                                          .onError((error, stackTrace) => {
                                                // print("$error"),
                                                // print("$stackTrace")
                                              });
                                    }),
                                ElevatedButton(
                                    child: Text("알림 끄기"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent),
                                    onPressed: () async {
                                      viewModel
                                          .turnOffNoti(item)
                                          .then((value) => {
                                                showToast("변경이 완료되었습니다."),
                                                Navigator.pop(context)
                                              })
                                          .onError((error, stackTrace) => {
                                                print("$error"),
                                                print("$stackTrace")
                                              });
                                    }),
                              ],
                            ))),
                  ],
                )));
      },
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("날짜검색"),
              )),
          flex: 1,
        ),
        Expanded(
          child: Container(
              // color: Colors.grey,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<List<NotiData>>(
                stream: viewModel.notiDataStream,
                builder: (context, snapshot) {
                  final List<NotiData> data =
                      snapshot.data?.cast<NotiData>() ?? [];
                  return Column(
                    children: [
                      Expanded(child: _buildContent(context, data)),
                    ],
                  );
                },
              )),
          flex: 9,
        )
      ],
    );
  }

  _buildContent(BuildContext context, data) {
    return viewModel.page == 0 && (data?.length == 0)
        ? const EmptyList().build(context)
        : _buildListView(data!);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
