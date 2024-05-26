import 'package:push_notify/routes.dart';
import 'package:flutter/material.dart';
import 'package:push_notify/ui/libraries/UniDialog.dart';

class BaseDrawer extends StatelessWidget {
  BaseDrawer({Key? key, Widget? child, String? semanticLabel});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 80,
            child: DrawerHeader(child: Text("부가기능")),
          ),
          Container(
              height: MediaQuery.of(context).size.height - 180,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('알림 보기'),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.mainPage,
                            arguments: {"title": "메인 페이지"});
                      },
                    ),
                    ListTile(
                      title: Text('달력 보기'),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.calendarPage,
                            arguments: {"title": "달력 보기"});
                      },
                    ),
                    ListTile(
                      title: Text('신규 알림 추가'),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.mainPage,
                            arguments: {"title": "메인 페이지"});
                      },
                    ),
                  ],
                ),
              )),
          Container(
              height: 80,
              child: Column(
                children: <Widget>[
                  Divider(),
                  ListTile(
                    title: Text("종료"),
                    onTap: () {
                      UniDialog.dialog(context,
                          title: "종료",
                          content: "종료하시겠습니까?",
                          positiveText: "예",
                          positive: () {
                            print("예");
                            Navigator.pop(context);
                          },
                          negativeText: "아니오",
                          negative: () {
                            print("아니오");
                            Navigator.pop(context);
                          });
                    },
                  )
                ],
              )),
        ],
      ),
    );
  }
}
