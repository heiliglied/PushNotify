import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UniDialog {
  UniDialog._();

  static void callDialog(BuildContext context, {
    required String title,
    required String content,
    required String positiveText,
    void Function()? positive,
    String? negativeText,
    void Function()? negative,
  }) {
    if(TargetPlatform.iOS == true) {
      _cupertinoDialog(
          context,
          title: title,
          content: content,
          positiveText: positiveText,
          positive: positive,
          negativeText: negativeText,
          negative: negative
      );
    } else {
      _showDialog(
        context,
        title: title,
        content: content,
        positiveText: positiveText,
        positive: positive,
        negativeText: negativeText,
        negative: negative
      );
    }
  }

  static void _showDialog(BuildContext context, {
    required String title,
    required String content,
    required String positiveText,
    void Function()? positive,
    String? negativeText,
    void Function()? negative,
  }) {
    showDialog(context: context,
        builder: (BuildContext context) =>
          AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(onPressed: () => { positive ?? _closeApp(context) }, child: Text(positiveText)),
              if(negativeText != '' || negativeText != null) TextButton(onPressed: () => { negative ?? _dismiss(context) }, child: Text(negativeText ?? '')),
            ],
          )
      );
  }

  static void _cupertinoDialog(BuildContext context, {
    required String title,
    required String content,
    required String positiveText,
    void Function()? positive,
    String? negativeText,
    void Function()? negative,
  }) {
    showDialog(context: context,
    builder: (BuildContext context) =>
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(child: Text(positiveText), onPressed:  () => { positive ?? _closeApp(context) }, isDefaultAction: true),
          if(negativeText != '' || negativeText != null)
            CupertinoDialogAction(child: Text(negativeText ?? ''), onPressed: () => {
              negative ?? _dismiss(context)
            }, isDefaultAction: true),
        ],
      )
    );
  }

  static void _closeApp(context) {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
  static void _dismiss(context) {
    Navigator.pop(context);
  }

  static void showToast(String message, String time) {
    Toast length = Toast.LENGTH_SHORT;
    if(time == 'long') {
      length = Toast.LENGTH_LONG;
    }

    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        gravity: ToastGravity.BOTTOM
    );
  }
}