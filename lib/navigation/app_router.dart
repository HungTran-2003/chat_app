import 'package:chat_app/features/auth/login/login_page.dart';
import 'package:chat_app/features/auth/register/register_page.dart';
import 'package:chat_app/features/call/call_page.dart';
import 'package:chat_app/features/chat_message/chat_message_page.dart';
import 'package:chat_app/features/contact/contact_detail/contact_detail_page.dart';
import 'package:chat_app/features/contact/contact_page.dart';
import 'package:chat_app/features/contact/contact_request_detail/contact_request_detail_page.dart';
import 'package:chat_app/features/intro/onboarding/onboarding_page.dart';
import 'package:chat_app/features/intro/splash/splash_page.dart';
import 'package:chat_app/features/main/main_page.dart';
import 'package:chat_app/features/chat/chat_page.dart';
import 'package:chat_app/features/search/add_contact/add_contact_page.dart';
import 'package:chat_app/features/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:chat_app/domain/models/entities/room_entity.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  // --- Route Paths ---
  static const String _splashPath = '/';
  static const String _onboardingPath = '/onboarding';
  static const String _loginPath = '/login';
  static const String _registerPath = '/register';
  static const String _chatPath = '/chat';
  static const String _callPath = '/call';
  static const String _contactPath = '/contact';
  static const String _settingPath = '/setting';
  static const String _searchAddContactPath = '/search-add-contact';
  static const String _contactDetailPath = '/contact-detail';
  static const String _contactRequestDetailPath = '/contact-request-detail';
  static const String _chatMessagePath = '/chat-message';

  // --- Route Names ---
  static const String splashRouteName = 'splash';
  static const String onboardingRouteName = 'onboarding';
  static const String loginRouteName = 'login';
  static const String registerRouteName = 'register';
  static const String chatRouterName = 'chat';
  static const String callRouterName = 'call';
  static const String contactRouterName = 'contact';
  static const String settingRouterName = 'setting';
  static const String searchAddContactRouterName = 'searchAddContact';
  static const String contactDetailRouterName = 'contactDetail';
  static const String contactRequestDetailRouterName = 'contactRequestDetail';
  static const String chatMessageRouterName = 'chatMessage';

  // --- Router ---

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
          path: _chatPath,
          name: chatRouterName,
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
    GoRoute(
      path: _searchAddContactPath,
      name: searchAddContactRouterName,
      builder: (context, state) => const AddContactPage(),
    ),
    GoRoute(
      path: _contactDetailPath,
      name: contactDetailRouterName,
      builder: (context, state) {
        final arg = state.extra as ContactDetailArgument;
        return ContactDetailPage(argument: arg);
      },
    ),
    GoRoute(
      path: _contactRequestDetailPath,
      name: contactRequestDetailRouterName,
      builder: (context, state) {
        final arg = state.extra as ContactRequestDetailArgument;
        return ContactRequestDetailPage(argument: arg);
      },
    ),
    GoRoute(
      path: _chatMessagePath,
      name: chatMessageRouterName,
      builder: (context, state) {
        final room = state.extra as RoomEntity;
        return ChatMessagePage(room: room);
      }
    )
  ];
}
