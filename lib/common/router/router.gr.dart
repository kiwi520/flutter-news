// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:news_app/pages/application/application.dart' as _i5;
import 'package:news_app/pages/details/details_page.dart' as _i6;
import 'package:news_app/pages/index/index.dart' as _i1;
import 'package:news_app/pages/sign_in/sign_in.dart' as _i3;
import 'package:news_app/pages/sign_up/sign_up.dart' as _i4;
import 'package:news_app/pages/welcome/welcome.dart' as _i2;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    IndexPageRoute.name: (routeData) {
      final args = routeData.argsAs<IndexPageRouteArgs>(
          orElse: () => const IndexPageRouteArgs());
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
    Detail.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<DetailArgs>(
          orElse: () => DetailArgs(
              title: queryParams.optString('title'),
              url: queryParams.optString('url')));
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.DetailsPage(args.title, args.url, key: args.key));
    },
    Details.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<DetailsArgs>(
          orElse: () => DetailsArgs(
              title: queryParams.optString('title'),
              url: queryParams.optString('url')));
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.DetailsPage(args.title, args.url, key: args.key));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(IndexPageRoute.name, path: '/'),
        _i7.RouteConfig(Welcome.name, path: '/welcome-page'),
        _i7.RouteConfig(SingIn.name, path: '/sign-in-page'),
        _i7.RouteConfig(SignUp.name, path: '/sign-up-page'),
        _i7.RouteConfig(Application.name, path: '/application-page'),
        _i7.RouteConfig(Detail.name, path: '/detail/:title/:url'),
        _i7.RouteConfig(Details.name, path: '/details')
      ];
}

/// generated route for [_i1.IndexPage]
class IndexPageRoute extends _i7.PageRouteInfo<IndexPageRouteArgs> {
  IndexPageRoute({_i8.Key? key})
      : super(name, path: '/', args: IndexPageRouteArgs(key: key));

  static const String name = 'IndexPageRoute';
}

class IndexPageRouteArgs {
  const IndexPageRouteArgs({this.key});

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
class Detail extends _i7.PageRouteInfo<DetailArgs> {
  Detail({required String? title, required String? url, _i8.Key? key})
      : super(name,
            path: '/detail/:title/:url',
            args: DetailArgs(title: title, url: url, key: key),
            rawPathParams: {},
            rawQueryParams: {'title': title, 'url': url});

  static const String name = 'Detail';
}

class DetailArgs {
  const DetailArgs({required this.title, required this.url, this.key});

  final String? title;

  final String? url;

  final _i8.Key? key;
}

/// generated route for [_i6.DetailsPage]
class Details extends _i7.PageRouteInfo<DetailsArgs> {
  Details({required String? title, required String? url, _i8.Key? key})
      : super(name,
            path: '/details',
            args: DetailsArgs(title: title, url: url, key: key),
            rawQueryParams: {'title': title, 'url': url});

  static const String name = 'Details';
}

class DetailsArgs {
  const DetailsArgs({required this.title, required this.url, this.key});

  final String? title;

  final String? url;

  final _i8.Key? key;
}
