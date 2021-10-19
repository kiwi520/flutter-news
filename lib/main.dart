import 'package:flutter/material.dart';
import 'package:news_app/global.dart';
import 'package:news_app/pages/welcome/welcome.dart';
import 'package:news_app/routes.dart';

// void main() => runApp(MyApp());
void main() => Global.init().then(
  (e) => runApp(MyApp())
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'news App',
      home: WelcomePage(),
      routes: staticRoutes,
      // showSemanticsDebugger: true,
    );
  }
}
