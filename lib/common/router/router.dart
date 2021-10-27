import 'package:auto_route/auto_route.dart';
import 'package:news_app/pages/application/application.dart';
import 'package:news_app/pages/details/details_page.dart';
import 'package:news_app/pages/index/index.dart';
import 'package:news_app/pages/sign_in/sign_in.dart';
import 'package:news_app/pages/sign_up/sign_up.dart';
import 'package:news_app/pages/welcome/welcome.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[

  AutoRoute(page: IndexPage, initial: true),
  AutoRoute(page: WelcomePage , name:'welcome'),
  AutoRoute(page: SignInPage , name:'singIn'),
  AutoRoute(page: SignUpPage , name:'signUp'),
  AutoRoute(page: ApplicationPage, name:'application'),
  AutoRoute(path: '/detail/:title/:url',page: DetailsPage, name:'detail'),
  AutoRoute(path: '/details',page: DetailsPage, name:'details'),
])
class $AppRouter {}