import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/utils/authentication.dart';

// mock auth state

var isAuth = false;

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    isAuth = await isAuthenticated();
    if (!isAuth) {

      print('no login');
      /// 去登录
      router.pushNamed('/sign-in-page');
    } else {
      resolver.next(true);
    }
  }
}

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}