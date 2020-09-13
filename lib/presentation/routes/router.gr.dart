// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';

import '../sign_in/sign_in_screen.dart';
import '../splash/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String signInScreen = '/sign-in-screen';
  static const all = <String>{
    splashScreen,
    signInScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.signInScreen, page: SignInScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    SignInScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => SignInScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<MaterialRoute<dynamic>> pushSplashScreen() =>
      push<MaterialRoute<dynamic>>(Routes.splashScreen);

  Future<MaterialRoute<dynamic>> pushSignInScreen() =>
      push<MaterialRoute<dynamic>>(Routes.signInScreen);
}
