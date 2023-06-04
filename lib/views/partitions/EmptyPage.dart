import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  EmptyPage({Key? key, this.message}) :  super(key: key);
  final String? message;

  Widget emptyWidget = Container(
    child: CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("데이터가 존재하지 않습니다.", style: TextStyle(fontSize: 24),),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return emptyWidget;
  }
}