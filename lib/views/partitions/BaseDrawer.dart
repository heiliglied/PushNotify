import 'package:push_notify/routes.dart';
import 'package:flutter/material.dart';

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
            child: const DrawerHeader(
              decoration: BoxDecoration(color: Colors.amber),
              child: Text('메뉴'),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 160,
            child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                    ListTile(
                      title: Text('알림 목록'),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.mainPage, arguments: {"title": "알림 목록"});
                      },
                    ),
                    ListTile(
                      title: Text('달력 보기'),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.mainPage, arguments: {"title": "달력 보기"});
                      },
                    ),
                    ListTile(
                      title: Text('신규 알림 추가'),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.mainPage, arguments: {"title": "신규 알림 추가"});
                      },
                    ),
                ],
              )
            ),
          ),
          Container(
            height: 80,
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: <Widget>[
                  Divider(),
                  ListTile(
                    title: Text('종료'),
                    onTap: () {
                      //종료하기
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}