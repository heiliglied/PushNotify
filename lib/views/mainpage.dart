import 'package:flutter/material.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("타이틀"),
      ),
      drawer: BaseDrawer(),
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