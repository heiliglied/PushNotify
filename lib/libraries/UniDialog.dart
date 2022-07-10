import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UniDialog {
  static void dialog(BuildContext context,
      {required String title,
      required String content,
      required String positiveText,
      required Function() positive,
      String? negativeText,
      Function()? negative}) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        List<Widget> action =
            _createAction(true, positiveText, positive, negativeText, negative);
        _showCupertinoDialog(context,
            title: title, content: content, action: action);
        break;
      default:
        List<Widget> action = _createAction(
            false, positiveText, positive, negativeText, negative);
        _showMaterialDialog(context,
            title: title, content: content, action: action);
        break;
    }
  }

  static List<Widget> _createAction(
      bool isIOs,
      String pt,
      Function() positiveFunction,
      String? nt,
      Function()? negativeFunction) {
    late List<Widget> action;
    if (isIOs) {
      if (nt != null) {
        action = <Widget>[
          CupertinoDialogAction(child: Text(pt), onPressed: positiveFunction),
          CupertinoDialogAction(child: Text(nt), onPressed: negativeFunction),
        ];
      } else {
        action = <Widget>[
          CupertinoDialogAction(child: Text(pt), onPressed: positiveFunction),
        ];
      }
    } else {
      if (nt != null) {
        action = <Widget>[
          TextButton(onPressed: positiveFunction, child: Text(pt)),
          TextButton(onPressed: negativeFunction, child: Text(nt)),
        ];
      } else {
        action = <Widget>[
          TextButton(onPressed: positiveFunction, child: Text(pt))
        ];
      }
    }
    return action;
  }

  static void _showMaterialDialog(BuildContext context,
      {required String title,
      required String content,
      required List<Widget> action}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: action,
            ));
  }

  static void _showCupertinoDialog(BuildContext context,
      {required String title,
      required String content,
      required List<Widget> action}) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: action,
            ));
  }

  void _dismiss(context) {
    Navigator.pop(context);
  }
}
