import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/service/MyService.dart';
import 'package:push_notify/ui/route/CommonRouteObserver.dart';

void main() {
  setupLocator();
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
      navigatorObservers: [AppNavObserver()],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', '')],
    );
  }
}
