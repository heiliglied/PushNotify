import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:push_notify/database/database.dart';
import 'package:push_notify/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    Provider<Database>(
      create: (context) => Database(),
      child: const Main(),
      dispose: (context, db) => db.close(),
    )
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.splash,
      routes: Routes.routes,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', '')],
    );
  }
}
