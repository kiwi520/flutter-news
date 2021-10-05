import 'package:flutter/material.dart';
import 'package:news_app/pages/welcome/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: WelcomePage(),
      // showSemanticsDebugger: true,
    );
  }
}
