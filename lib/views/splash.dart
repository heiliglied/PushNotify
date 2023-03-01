import 'dart:async';
import 'package:flutter/material.dart';
import 'package:push_notify/routes.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);
  @override
  //_SplashPage createState() => _SplashPage();
  _SplashPage createState() {
    return new _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4), () => Navigator.of(context).pushNamed(Routes.mainPage)
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/webp.jpg'), fit: BoxFit.contain),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}