import 'dart:ui';

import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/dialog/app_dialog.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseNavigator {
  BuildContext context;

  BaseNavigator({required this.context});

  /// Navigates to the specified route using GoRouter.
  void pop<T extends Object?>([T? result]) {
    GoRouter.of(context).pop(result);
  }

  /// Pops if possible, otherwise navigates to home.
  void popOrGoHome() {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
    } else {
      router.go(AppRouter.chatRouterName);
    }
  }

  /// Pops the current route until the specified route is reached.
  void popUntilNamed(String name) {
    Navigator.popUntil(context, ModalRoute.withName(name));
  }

  Future<dynamic> goNamed(String name, {Object? extra}) async {
    return GoRouter.of(context).goNamed(name, extra: extra);
  }

  /// Pushes a new route onto the navigator stack.
  Future<dynamic> pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Replaces the current route with a new one.
  Future<dynamic> pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushReplacementNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Pushes a new page onto the navigator stack using a MaterialPageRoute.
  Future<dynamic> pushPage(Widget page) async {
    final context = AppRouter.navigationKey.currentContext;
    if (context == null) {
      return Future.error('Context is null');
    }
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  Future<void> openLoginPage() {
    return goNamed(AppRouter.loginRouteName);
  }

  Future<DialogAction> showAppDialog({
    required DialogType dialogType,
    required String titleText,
    required String messageText,
    String? confirmButtonText,
    String? declineButtonText,
  }) async {
    return AppDialog.show(
      context: context,
      titleText: titleText,
      messageText: messageText,
      confirmButtonText: confirmButtonText ?? "Ok",
      declineButtonText: declineButtonText ?? "Cancel",
      dialogType: dialogType,
    );
  }

  Future<void> showErrorDialog({
    String? title,
    required String message,
    VoidCallback? closeAction,
  }) async {
    await AppDialog.show(
      dialogType: DialogType.errorAlert,
      context: context,
      titleText: title ?? "Error",
      messageText: message,
      confirmButtonText: "Close",
      declineButtonText: "Cancel",
    );
    closeAction?.call();
  }

  Future<T?> showAppBottomSheet<T>({
    required Widget child,
    Color? backgroundColor,
  }) async {
    final result = await showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: backgroundColor ?? AppColors.backgroundLight,
      builder: (context) {
        return child;
      },
    );
    return result;
  }

  void showSuccessSnackBar({
    required String message,
    Duration? duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: duration!,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.green.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [Text(message, style: AppTextStyle.black.s14.w500)],
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
