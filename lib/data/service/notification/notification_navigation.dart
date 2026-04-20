import 'dart:developer';

import 'package:chat_app/navigation/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ─────────────────────────────────────────────────────────────────────────────
// NotificationNavigation
//
// Trách nhiệm DUY NHẤT: **Navigation** khi user bấm vào notification.
//
// Xử lý đầy đủ 3 trường hợp:
//  [1] App đang mở (foreground)         → navigate ngay lập tức.
//  [2] App ở nền (background)           → navigate ngay khi context sẵn sàng.
//  [3] App bị kill (terminated)         → lưu pending, execute sau khi UI init.
//
// Xử lý trường hợp user chưa đăng nhập:
//  → Lưu pending navigation, redirect về Login.
//  → Sau khi user đăng nhập xong → gọi [executePendingNavigation()] để navigate.
//
// Payload convention (FCM data field):
//  {
//    "screen": "chat" | "call" | "contact" | "setting" | "home",
//    "chat_id": "<optional>",   // dùng cho screen=chat
//    "user_id": "<optional>",   // dùng cho screen=chat
//    ...
//  }
// ─────────────────────────────────────────────────────────────────────────────
class NotificationNavigation {
  NotificationNavigation._internal();

  static final NotificationNavigation instance =
      NotificationNavigation._internal();

  /// Dữ liệu navigation đang chờ (khi context chưa sẵn sàng hoặc user chưa đăng nhập).
  Map<String, dynamic>? _pendingData;

  /// Cờ chống navigate đúp (race condition giữa foreground/background listener).
  bool _isNavigating = false;

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Lưu dữ liệu navigation vào pending.
  /// Dùng khi app bị kill (case 3) hoặc khi background isolate nhận tap.
  void setPendingNavigation(Map<String, dynamic> data) {
    if (data.isEmpty) return;
    _pendingData = data;
    log('[NotificationNavigation] Pending set: $data');
  }

  /// Xử lý navigation ngay khi nhận được data.
  /// Gọi từ:
  ///  - [NotificationService] khi app ở background + user tap (case 2).
  ///  - [NotificationLocal] khi user tap notification trong foreground (case 1).
  void handleNavigation(Map<String, dynamic> data) {
    if (data.isEmpty) return;
    log('[NotificationNavigation] Handle navigation: $data');
    _processData(data);
  }

  /// Thực thi pending navigation nếu có.
  /// Gọi sau khi:
  ///  - App khởi động xong (addPostFrameCallback trong NotificationService).
  ///  - User đăng nhập thành công.
  Future<void> executePendingNavigation() async {
    final data = _pendingData;
    if (data == null) return;

    log('[NotificationNavigation] Executing pending: $data');
    _pendingData = null;
    _processData(data);
  }

  /// Xoá pending navigation (dùng khi user logout hoặc reset state).
  void clearPendingNavigation() {
    _pendingData = null;
    log('[NotificationNavigation] Pending cleared.');
  }

  // ── Core Logic ─────────────────────────────────────────────────────────────

  Future<void> _processData(Map<String, dynamic> data) async {
    if (_isNavigating) {
      log('[NotificationNavigation] Already navigating, skipped.');
      return;
    }

    // Lấy NavigatorState từ GoRouter's navigatorKey.
    final navigatorState = AppRouter.navigationKey.currentState;
    final context = navigatorState?.context;

    final isContextReady = context != null && context.mounted;

    // Nếu context chưa sẵn sàng → lưu pending và chờ.
    if (!isContextReady) {
      log('[NotificationNavigation] Context not ready, saving pending.');
      _pendingData = data;
      return;
    }

    // Kiểm tra trạng thái đăng nhập qua FirebaseAuth.
    final isLoggedIn = _checkLoginStatus();

    if (!isLoggedIn) {
      // User chưa đăng nhập → lưu pending, redirect về Login.
      log('[NotificationNavigation] User not logged in, redirecting to login.');
      _pendingData = data;
      _redirectToLogin(context);
      return;
    }

    // Tất cả điều kiện đã thoả → thực hiện navigate.
    _isNavigating = true;
    try {
      _performNavigation(context, data);
    } finally {
      // Reset sau một frame để tránh block navigate tiếp theo.
      Future.delayed(const Duration(milliseconds: 300), () {
        _isNavigating = false;
      });
    }
  }

  // ── Navigation execution ───────────────────────────────────────────────────

  void _performNavigation(BuildContext context, Map<String, dynamic> data) {
    if (!context.mounted) return;

    final screen = data['screen']?.toString();
    if (screen == null || screen.isEmpty) {
      log('[NotificationNavigation] No "screen" key in payload, skipped.');
      return;
    }

    log('[NotificationNavigation] Navigating to screen="$screen"');

    switch (screen) {
      // ── Màn hình Chat (cần chat_id) ────────────────────────────────────────
      case 'chat':
        final chatId = data['chat_id']?.toString();
        if (chatId != null && chatId.isNotEmpty) {
          _navigateToChat(context, chatId: chatId, extraData: data);
        } else {
          // Không có chatId → vào trang danh sách chat.
          _navigateToRoute(context, AppRouter.chatRouterName);
        }
        break;

      // ── Màn hình Cuộc gọi ──────────────────────────────────────────────────
      case 'call':
        _navigateToRoute(context, AppRouter.callRouterName);
        break;

      // ── Màn hình Danh bạ ───────────────────────────────────────────────────
      case 'contact':
        _navigateToRoute(context, AppRouter.contactRouterName);
        break;

      // ── Màn hình Cài đặt ───────────────────────────────────────────────────
      case 'setting':
        _navigateToRoute(context, AppRouter.settingRouterName);
        break;

      // ── Màn hình Home / Chat list (default) ───────────────────────────────
      case 'home':
      default:
        _navigateToRoute(context, AppRouter.chatRouterName);
        break;
    }
  }

  // ── Navigate helpers ───────────────────────────────────────────────────────

  /// Navigate đến route theo tên (GoRouter named route).
  void _navigateToRoute(BuildContext context, String routeName) {
    if (!context.mounted) return;
    try {
      context.goNamed(routeName);
    } catch (e) {
      log('[NotificationNavigation] Navigate error: $e');
    }
  }

  /// Navigate đến màn hình chat cụ thể với [chatId].
  /// Nếu app chưa có màn hình message riêng, mở danh sách chat và truyền extra.
  void _navigateToChat(
    BuildContext context, {
    required String chatId,
    Map<String, dynamic>? extraData,
  }) {
    if (!context.mounted) return;
    try {
      // TODO: Khi có màn hình chat chi tiết, thay bằng route name của nó.
      // Ví dụ: context.pushNamed(AppRouter.messageDetailRouteName, extra: extraData);
      context.goNamed(
        AppRouter.chatRouterName,
        extra: extraData,
      );
      log('[NotificationNavigation] Navigated to chat id=$chatId');
    } catch (e) {
      log('[NotificationNavigation] Navigate to chat error: $e');
    }
  }

  /// Redirect user về màn hình Login khi chưa đăng nhập.
  void _redirectToLogin(BuildContext context) {
    if (!context.mounted) return;
    try {
      context.goNamed(AppRouter.loginRouteName);
    } catch (e) {
      log('[NotificationNavigation] Redirect to login error: $e');
    }
  }

  // ── Auth check ─────────────────────────────────────────────────────────────

  /// Kiểm tra trạng thái đăng nhập qua FirebaseAuth (đồng bộ, không async).
  bool _checkLoginStatus() {
    try {
      return FirebaseAuth.instance.currentUser != null;
    } catch (_) {
      return false;
    }
  }
}
