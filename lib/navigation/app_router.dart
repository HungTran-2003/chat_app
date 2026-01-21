import 'package:chat_app/features/auth/login/login_page.dart';
import 'package:chat_app/features/auth/register/register_page.dart';
import 'package:chat_app/features/call/call_page.dart';
import 'package:chat_app/features/contact/contact_page.dart';
import 'package:chat_app/features/intro/onboarding/onboarding_page.dart';
import 'package:chat_app/features/intro/splash/splash_page.dart';
import 'package:chat_app/features/main/main_page.dart';
import 'package:chat_app/features/message/message_page.dart';
import 'package:chat_app/features/setting/setting_page.dart';
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
  static const String _messagePath = '/message';
  static const String _callPath = '/call';
  static const String _contactPath = '/contact';
  static const String _settingPath = '/setting';


  // --- Route Names ---
  static const String splashRouteName = 'splash';
  static const String onboardingRouteName = 'onboarding';
  static const String loginRouteName = 'login';
  static const String registerRouteName = 'register';
  static const String forgotPasswordRouteName = 'forgotPassword';
  static const String messageRouterName = 'home';
  static const String callRouterName = 'call';
  static const String contactRouterName = 'contact';
  static const String settingRouterName = 'setting';

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
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return const MainPage();
      },
      routes: [
        GoRoute(
          path: _messagePath,
          name: messageRouterName,
          builder: (context, state) => const MessagePage(),
        ),
        GoRoute(
          path: _callPath,
          name: callRouterName,
          builder: (context, state) => const CallPage(),
        ),
        GoRoute(
          path: _contactPath,
          name: contactRouterName,
          builder: (context, state) => const ContactPage(),
        ),
        GoRoute(
          path: _settingPath,
          name: settingRouterName,
          builder: (context, state) => const SettingPage(),
        ),
      ],
    ),
  ];
}