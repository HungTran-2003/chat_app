import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_navigation.dart';

// ─────────────────────────────────────────────────────────────────────────────
// NotificationLocal
//
// Trách nhiệm DUY NHẤT: **Hiển thị** local notification trên Android khi
// app đang ở foreground (FCM không tự hiển thị trong trường hợp này).
//
// Nhiệm vụ cụ thể:
//  • Tạo Android Notification Channel.
//  • Khởi tạo FlutterLocalNotificationsPlugin.
//  • Hiển thị notification từ RemoteMessage (foreground FCM message).
//  • Hiển thị notification tuỳ chỉnh từ code (nếu cần).
//  • Lắng nghe tap vào notification → chuyển sang NotificationNavigation.
// ─────────────────────────────────────────────────────────────────────────────
class NotificationLocal {
  NotificationLocal._internal();

  static final NotificationLocal instance = NotificationLocal._internal();

  // ── Android Channel Constants ──────────────────────────────────────────────
  static const String channelId = 'chat_app_channel';
  static const String channelName = 'Chat App Notifications';
  static const String channelDescription =
      'Nhận thông báo tin nhắn và cuộc gọi mới';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ── Init ───────────────────────────────────────────────────────────────────

  /// Khởi tạo plugin và tạo Android notification channel.
  /// Gọi một lần duy nhất từ [NotificationService.init()].
  Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      initSettings,
      // Callback khi user bấm vào notification đang hiển thị
      // (app ở foreground hoặc vừa resume từ background).
      onDidReceiveNotificationResponse: _onNotificationTapped,
      // Callback khi user bấm vào notification khi app ở background
      // nhưng chưa bị kill — chạy trên background isolate.
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationTapped,
    );

    await _createAndroidChannel();
    log('[NotificationLocal] Initialized successfully.');
  }

  // ── Show notification ──────────────────────────────────────────────────────

  /// Hiển thị notification từ FCM [RemoteMessage].
  /// Dùng trong foreground handler của [NotificationService].
  Future<void> showFromRemoteMessage(RemoteMessage message) async {
    final title = _resolveTitle(message);
    final body = _resolveBody(message);

    if (title == null || title.isEmpty || body == null || body.isEmpty) {
      log('[NotificationLocal] Empty title/body — skipped.');
      return;
    }

    await _show(
      id: message.hashCode,
      title: title,
      body: body,
      payload: message.data,
    );
  }

  /// Hiển thị notification tuỳ chỉnh (không qua FCM).
  Future<void> showCustom({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    await _show(id: id, title: title, body: body, payload: payload);
  }

  // ── Dismiss ────────────────────────────────────────────────────────────────

  /// Ẩn một notification theo [id].
  Future<void> dismiss(int id) async {
    await _plugin.cancel(id);
  }

  /// Ẩn tất cả notification đang hiển thị.
  Future<void> dismissAll() async {
    await _plugin.cancelAll();
  }

  // ── Private ────────────────────────────────────────────────────────────────

  Future<void> _createAndroidChannel() async {
    const channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableVibration: true,
      enableLights: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    log('[NotificationLocal] Android channel "$channelId" created.');
  }

  Future<void> _show({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    final cleanTitle = title.trim();
    final cleanBody = body.trim();

    if (cleanTitle.isEmpty || cleanBody.isEmpty) return;

    const androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      showWhen: true,
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.message,
      channelShowBadge: true,
    );

    const details = NotificationDetails(android: androidDetails);

    try {
      await _plugin.show(
        id,
        cleanTitle,
        cleanBody,
        details,
        payload: payload != null ? jsonEncode(payload) : null,
      );
      log('[NotificationLocal] Shown id=$id title="$cleanTitle"');
    } catch (e) {
      log('[NotificationLocal] Error showing notification: $e');
    }
  }

  // ── Tap callbacks ──────────────────────────────────────────────────────────

  /// Gọi khi user bấm vào notification khi app đang mở hoặc vừa resume.
  void _onNotificationTapped(NotificationResponse response) {
    log('[NotificationLocal] Notification tapped. id=${response.id}');
    _routeFromPayload(response.payload);
  }

  /// Top-level callback cho background isolate — bắt buộc là static/top-level.
  /// Được gọi khi user bấm vào notification khi app ở background nhưng chưa kill.
  @pragma('vm:entry-point')
  static void _onBackgroundNotificationTapped(NotificationResponse response) {
    // Chạy trong isolate riêng — không thể truy cập NavigatorState.
    // Lưu payload vào pending để NotificationNavigation xử lý khi app resume.
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!) as Map<String, dynamic>;
        NotificationNavigation.instance.setPendingNavigation(data);
      } catch (_) {}
    }
  }

  void _routeFromPayload(String? payloadJson) {
    if (payloadJson == null) return;
    try {
      final data = jsonDecode(payloadJson) as Map<String, dynamic>;
      NotificationNavigation.instance.handleNavigation(data);
    } catch (e) {
      log('[NotificationLocal] Error parsing payload: $e');
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String? _resolveTitle(RemoteMessage message) {
    final fromNotification = message.notification?.title?.trim();
    if (fromNotification != null && fromNotification.isNotEmpty) {
      return fromNotification;
    }
    return message.data['title']?.toString().trim();
  }

  String? _resolveBody(RemoteMessage message) {
    final fromNotification = message.notification?.body?.trim();
    if (fromNotification != null && fromNotification.isNotEmpty) {
      return fromNotification;
    }
    return message.data['body']?.toString().trim();
  }
}
