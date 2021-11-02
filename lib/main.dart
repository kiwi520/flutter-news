import 'package:flutter/material.dart';
import 'package:news_app/common/providers/app_provider.dart';
import 'package:news_app/common/providers/application_provider.dart';
import 'package:news_app/common/providers/category_provider.dart';
import 'package:news_app/common/providers/channels_provider.dart';
import 'package:news_app/common/providers/news_list_provider.dart';
import 'package:news_app/common/providers/news_recommend_provider.dart';
import 'package:news_app/common/router/auth_grard.dart';
import 'package:news_app/common/router/router.gr.dart';
import 'package:news_app/global.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// void main() => runApp(MyApp());
void main() => Global.init().then((e) async => await SentryFlutter.init(
      (options) {
        options.dsn = 'https://ab259704b8e042bdb8d799eb5ca916c3@o1057134.ingest.sentry.io/6043780';
      },
      // Init your App.
      appRunner: () => runApp(
        MultiProvider(
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
        ),
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    final _appRouter = AppRouter(authGuard: AuthGuard());
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ApplicationProvider>(
              create: (_) => ApplicationProvider()),
          ChangeNotifierProvider<CategoryProvider>(
              create: (_) => CategoryProvider()),
          ChangeNotifierProvider<newsRecommendProvider>(
              create: (_) => newsRecommendProvider()),
          ChangeNotifierProvider<channelsProvider>(
              create: (_) => channelsProvider()),
          ChangeNotifierProvider<newsPageListProvider>(
              create: (_) => newsPageListProvider())
        ],
        builder: (context, _) {
          return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
              routeInformationProvider: PlatformRouteInformationProvider(
                initialRouteInformation: RouteInformation(
                  location: '/',
                ),
              ));
          ;
        });
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Provider.debugCheckInvalidValueType = null;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'news App',
//       home: IndexPage(),
//       routes: staticRoutes,
//       // showSemanticsDebugger: true,
//     );
//   }
// }
