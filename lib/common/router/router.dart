import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/router/auth_grard.dart';
import 'package:news_app/pages/application/application.dart';
import 'package:news_app/pages/details/details_page.dart';
import 'package:news_app/pages/index/index.dart';
import 'package:news_app/pages/sign_in/sign_in.dart';
import 'package:news_app/pages/sign_up/sign_up.dart';
import 'package:news_app/pages/welcome/welcome.dart';


Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  // you get an animation object and a widget
  // make your own transition
  return ScaleTransition(scale: animation, child: child);
}



// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: IndexPage, initial: true),
    AutoRoute(page: WelcomePage , name:'welcome'),
    AutoRoute(page: SignInPage , name:'singIn'),
    AutoRoute(page: SignUpPage , name:'signUp'),
    AutoRoute(page: ApplicationPage, name:'application',guards: [AuthGuard]),
    // AutoRoute(path: '/detail/:title/:url',page: DetailsPage, name:'detail'),
    // AutoRoute(path: '/details',page: DetailsPage, name:'details',guards: [AuthGuard]),
    // CustomRoute(path: '/detail/:item',page: DetailsPage, name:'details',guards: [AuthGuard], transitionsBuilder: zoomInTransition),
    CustomRoute(page: DetailsPage, name:'details',guards: [AuthGuard], transitionsBuilder: zoomInTransition),
  ],
)
class $AppRouter {}