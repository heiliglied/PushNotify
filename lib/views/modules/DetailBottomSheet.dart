import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:push_notify/database/database.dart';

class DetailBottomSheet {
  Future showBottomSheet(BuildContext context, NotificationData item) {
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
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                              child: Text("알림 끄기"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent
                              ),
                              onPressed: () async {

                              }
                          ),
                        )
                    ),
                  ],
                )
            )
        );
      },
    );
  }
}
