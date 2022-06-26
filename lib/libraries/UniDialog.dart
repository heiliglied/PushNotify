import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UniDialog {
  static void dialog(BuildContext context, {
    required String title,
    required String content,
    required String positiveText,
    required void Function() positive,
    String? negativeText,
    Function()? negative,
    //void Function() negative,
  }) {
    if(TargetPlatform.iOS == true) {

    } else if(TargetPlatform.android == true) {
      //android
    }
  }

  void _dismiss(context) {
    Navigator.pop(context);
  }
}