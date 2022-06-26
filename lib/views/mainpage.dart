import 'package:flutter/material.dart';
import 'package:push_notify/views/partitions/BaseAppBar.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("메시지 알리미"),
      endDrawer: BaseDrawer(),
      body: Column(
        children: [
          SizedBox(
            
          ),
          // )
        ],
      ),
    );
  }
}