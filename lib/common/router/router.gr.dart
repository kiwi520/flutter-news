// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:news_app/common/entity/news_list_response_entity.dart' as _i11;
import 'package:news_app/common/router/auth_grard.dart' as _i9;
import 'package:news_app/common/router/router.dart' as _i10;
import 'package:news_app/pages/application/application.dart' as _i5;
import 'package:news_app/pages/details/details_page.dart' as _i6;
import 'package:news_app/pages/index/index.dart' as _i1;
import 'package:news_app/pages/sign_in/sign_in.dart' as _i3;
import 'package:news_app/pages/sign_up/sign_up.dart' as _i4;
import 'package:news_app/pages/welcome/welcome.dart' as _i2;

class AppRouter extends _i7.RootStackRouter {
  AppRouter(
      {_i8.GlobalKey<_i8.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i9.AuthGuard authGuard;

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    IndexRoute.name: (routeData) {
      final args = routeData.argsAs<IndexRouteArgs>(
          orElse: () => const IndexRouteArgs());
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.IndexPage(key: args.key));
    },
    Welcome.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.WelcomePage());
    },
    SingIn.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SignInPage());
    },
    SignUp.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.SignUpPage());
    },
    Application.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.ApplicationPage());
    },
    Details.name: (routeData) {
      final args = routeData.argsAs<DetailsArgs>();
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: _i6.DetailsPage(item: args.item, key: args.key),
          transitionsBuilder: _i10.zoomInTransition,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(IndexRoute.name, path: '/'),
        _i7.RouteConfig(Welcome.name, path: '/welcome-page'),
        _i7.RouteConfig(SingIn.name, path: '/sign-in-page'),
        _i7.RouteConfig(SignUp.name, path: '/sign-up-page'),
        _i7.RouteConfig(Application.name,
            path: '/application-page', guards: [authGuard]),
        _i7.RouteConfig(Details.name,
            path: '/details-page', guards: [authGuard])
      ];
}

/// generated route for [_i1.IndexPage]
class IndexRoute extends _i7.PageRouteInfo<IndexRouteArgs> {
  IndexRoute({_i8.Key? key})
      : super(name, path: '/', args: IndexRouteArgs(key: key));

  static const String name = 'IndexRoute';
}

class IndexRouteArgs {
  const IndexRouteArgs({this.key});

  final _i8.Key? key;
}

/// generated route for [_i2.WelcomePage]
class Welcome extends _i7.PageRouteInfo<void> {
  const Welcome() : super(name, path: '/welcome-page');

  static const String name = 'Welcome';
}

/// generated route for [_i3.SignInPage]
class SingIn extends _i7.PageRouteInfo<void> {
  const SingIn() : super(name, path: '/sign-in-page');

  static const String name = 'SingIn';
}

/// generated route for [_i4.SignUpPage]
class SignUp extends _i7.PageRouteInfo<void> {
  const SignUp() : super(name, path: '/sign-up-page');

  static const String name = 'SignUp';
}

/// generated route for [_i5.ApplicationPage]
class Application extends _i7.PageRouteInfo<void> {
  const Application() : super(name, path: '/application-page');

  static const String name = 'Application';
}

/// generated route for [_i6.DetailsPage]
class Details extends _i7.PageRouteInfo<DetailsArgs> {
  Details({required _i11.Items item, _i8.Key? key})
      : super(name,
            path: '/details-page', args: DetailsArgs(item: item, key: key));

  static const String name = 'Details';
}

class DetailsArgs {
  const DetailsArgs({required this.item, this.key});

  final _i11.Items item;

  final _i8.Key? key;
}
