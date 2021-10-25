import 'package:flutter/material.dart';
import 'package:news_app/common/providers/app_provider.dart';
import 'package:news_app/global.dart';
import 'package:news_app/pages/index/index.dart';
import 'package:news_app/routes.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());
void main() => Global.init().then((e) => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(),
          builder: (contenxt, _) {
            return Consumer<AppProvider>(
              builder: (context, appState, _) {
                if (appState.isGrayFilter) {
                  return ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.color),
                    child: MyApp(),
                  );
                } else {
                  return MyApp();
                }
              },
            );
          },
        )
      ],
    )));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'news App',
      home: IndexPage(),
      routes: staticRoutes,
      // showSemanticsDebugger: true,
    );
  }
}
