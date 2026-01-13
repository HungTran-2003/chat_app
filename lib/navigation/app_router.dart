import 'package:chat_app/features/intro/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  // --- Route Paths ---
  static const String _splashPath = '/';
  static const String _loginPath = '/login';
  static const String _forgotPasswordPath = '/forgot-password';
  static const String _homePath = '/home';


  static const String splashRouteName = 'splash';
  static const String loginRouteName = 'login';
  static const String forgotPasswordRouteName = 'forgotPassword';
  static const String homeName = 'home';

  static final GoRouter router = GoRouter(
    initialLocation: _splashPath,
    routes: _routes,
    navigatorKey: navigationKey,
    debugLogDiagnostics: true,
  );

  static final _routes = <RouteBase>[
    GoRoute(
      name: splashRouteName,
      path: _splashPath,
      builder: (context, state) => const SplashPage(),
    ),
  ];
}