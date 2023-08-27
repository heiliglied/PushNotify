import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/database/database.dart';
import 'package:provider/provider.dart';

class DetailBottomSheet {
  Future showBottomSheet(BuildContext context, NotificationData item, int index) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.4, // 모달 높이 크기
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
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.lightBlue,
                                width: 2,
                              )
                          )
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text("지정시간", style: TextStyle(fontSize: 18)),
                          ),
                          Expanded(
                              child: Text("${DateFormat('yyyy-MM-dd HH:mm').format(item.date)}", style: TextStyle(fontSize: 18))
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.lightBlue,
                                width: 2,
                              )
                          )
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text("제목", style: TextStyle(fontSize: 18)),
                          ),
                          Expanded(
                              child: Text("${item.title}", style: TextStyle(fontSize: 18))
                          )
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
                                      child: Text("${item.contents}", style: TextStyle(fontSize: 18))
                                  )
                                ],
                              ),
                            )
                        )
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                  color: Colors.lightBlue,
                                  width: 2,
                                )
                            )
                        ),
                        height: 50,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                              ElevatedButton(
                                  child: Text("알림 수정"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlueAccent
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, Routes.set, arguments: {"title": "알림 수정", "id": item.id});
                                  }
                              ),
                              Container(
                                width: 5,
                              ),
                              ElevatedButton(
                                  child: Text("알림 끄기"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black12
                                  ),
                                  onPressed: () async {
                                    updateNoti(context, item.id, NotificationCompanion(
                                      status: Value(true),
                                    ));
                                    Navigator.pop(context, index);
                                  }
                              ),
                              Container(
                                width: 5,
                              ),
                              ElevatedButton(
                                  child: Text("알림 삭제"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent
                                  ),
                                  onPressed: () async {
                                    deleteNoti(context, item.id);
                                    Navigator.pop(context, index);
                                  }
                              )
                          ],
                        )
                    ),
                  ],
                )
            )
        );
      },
    );
  }

  Future<int> updateNoti(BuildContext context, int id, NotificationCompanion noti) async {
    return Provider.of<Database>(context, listen: false).updateNoti(id, noti);
  }

  Future<int> deleteNoti(BuildContext context, int id) async {
    return Provider.of<Database>(context, listen: false).deleteNoti(id);
  }
}
