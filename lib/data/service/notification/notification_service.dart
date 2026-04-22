import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'notification_local.dart';
import 'notification_navigation.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Background handler — PHẢI là top-level function, chạy trong isolate riêng
// khi app bị kill hoặc đang ở background.
// ─────────────────────────────────────────────────────────────────────────────
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  // Khi app bị kill: nếu FCM payload có notification object → Android tự hiển thị.
  // Chỉ cần xử lý data-only message (không có notification object).
  if (message.notification == null) {
    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );

    final title = message.data['title']?.toString();
    final body = message.data['body']?.toString();

    if (title != null &&
        body != null &&
        title.isNotEmpty &&
        body.isNotEmpty) {
      await plugin.show(
        message.hashCode,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            NotificationLocal.channelId,
            NotificationLocal.channelName,
            channelDescription: NotificationLocal.channelDescription,
            importance: Importance.max,
            priority: Priority.high,
            visibility: NotificationVisibility.public,
            category: AndroidNotificationCategory.message,
          ),
        ),
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NotificationService
//
// Trách nhiệm:
//  • Đăng ký background handler.
//  • Xin quyền POST_NOTIFICATIONS (Android 13+).
//  • Khởi tạo FCM token và lắng nghe token refresh.
//  • Kết nối 3 trường hợp FCM:
//      [1] onMessage         → foreground  → NotificationLocal hiển thị
//      [2] onMessageOpenedApp→ background tap → NotificationNavigation
//      [3] getInitialMessage → killed tap  → NotificationNavigation (pending)
// ─────────────────────────────────────────────────────────────────────────────
class NotificationService {
  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  String? fcmToken;
  bool _isInitialized = false;

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Gọi một lần duy nhất sau khi Firebase.initializeApp() hoàn thành.
  /// Truyền [context] để kích hoạt pending navigation sau khi UI sẵn sàng.
  Future<void> init(BuildContext context) async {
    // 1. Đăng ký background handler — bắt buộc trước mọi thứ khác.
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 2. Lấy FCM token (không cần quyền notification).
    await _initFCMToken();

    // 3. Xin quyền POST_NOTIFICATIONS (Android 13+ = API 33+).
    final granted = await requestPermission();
    if (!granted) {
      log('[NotificationService] Permission denied, skipping setup.');
      return;
    }

    if (_isInitialized) return;
    _isInitialized = true;

    // 4. Khởi tạo NotificationLocal (tạo channel, init plugin).
    await NotificationLocal.instance.init();

    // 5. Cài đặt tất cả message handler.
    await _setupMessageHandlers();

    // 6. Sau khi widget tree render xong → thực thi pending navigation
    //    (dành cho trường hợp app bị kill và mở bằng notification).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationNavigation.instance.executePendingNavigation();
    });
  }

  /// Kiểm tra quyền notification hiện tại (không hỏi lại).
  Future<bool> isPermissionGranted() async {
    return await Permission.notification.isGranted;
  }

  /// Yêu cầu quyền notification từ user (Android 13+).
  Future<bool> requestPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  // ── Private ────────────────────────────────────────────────────────────────

  Future<void> _initFCMToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        fcmToken = token;
        log('[NotificationService] FCM Token: $token');
        // TODO: Gửi token lên Supabase/backend để lưu cho user.
      }

      // Lắng nghe khi token bị làm mới (uninstall/reinstall, xoá data…).
      _messaging.onTokenRefresh.listen((newToken) {
        fcmToken = newToken;
        log('[NotificationService] FCM Token refreshed: $newToken');
        // TODO: Cập nhật token mới lên backend.
      });
    } catch (e) {
      log('[NotificationService] FCM token error: $e');
    }
  }

  Future<void> _setupMessageHandlers() async {
    // ── [1] Foreground: app đang mở ──────────────────────────────────────────
    // FCM KHÔNG tự hiển thị notification khi app ở foreground trên Android.
    // Ta phải dùng flutter_local_notifications để hiển thị thủ công.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('[NotificationService] Foreground message: ${message.messageId}');
      NotificationLocal.instance.showFromRemoteMessage(message);
    });

    // ── [2] Background: app ở nền, user bấm vào notification ─────────────────
    // Android đã tự hiển thị notification. Ta chỉ lo phần navigation.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('[NotificationService] Background tap: ${message.messageId}');
      NotificationNavigation.instance.handleNavigation(message.data);
    });

    // ── [3] Killed: app bị tắt, user bấm vào notification → app khởi động ───
    // getInitialMessage() trả về message gốc. Navigation cần đợi router
    // sẵn sàng → lưu pending và execute trong addPostFrameCallback (trên).
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      log('[NotificationService] Killed-state tap: ${initialMessage.messageId}');
      NotificationNavigation.instance.setPendingNavigation(initialMessage.data);
    }
  }
}
