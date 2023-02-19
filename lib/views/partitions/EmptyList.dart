

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget{

  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(20),
      child:Container(
        child: Column(
          children: const [
            Text("데이터가 존재하지 않습니다.")
          ],
        ),
    )
    );
  }

}