import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Text("데이터가 존재하지 않습니다.")],
    );
  }
}
