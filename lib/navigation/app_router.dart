import 'package:chat_app/features/auth/login/login_page.dart';
import 'package:chat_app/features/auth/register/register_page.dart';
import 'package:chat_app/features/home/home_page.dart';
import 'package:chat_app/features/intro/onboarding/onboarding_page.dart';
import 'package:chat_app/features/intro/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  // --- Route Paths ---
  static const String _splashPath = '/';
  static const String _onboardingPath = '/onboarding';
  static const String _loginPath = '/login';
  static const String _registerPath = '/register';
  static const String _forgotPasswordPath = '/forgot-password';
  static const String _homePath = '/home';

  // --- Route Names ---
  static const String splashRouteName = 'splash';
  static const String onboardingRouteName = 'onboarding';
  static const String loginRouteName = 'login';
  static const String registerRouteName = 'register';
  static const String forgotPasswordRouteName = 'forgotPassword';
  static const String homeRouterName = 'home';

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
    GoRoute(
      name: onboardingRouteName,
      path: _onboardingPath,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      name: loginRouteName,
      path: _loginPath,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: registerRouteName,
      path: _registerPath,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      name: homeRouterName,
      path: _homePath,
      builder: (context, state) => const HomePage(),
    )
  ];
}