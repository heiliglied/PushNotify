import 'package:flutter/material.dart';
import 'package:push_notify/routes.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Routes.mainPage,
        routes: Routes.routes,
    );
  }
}
