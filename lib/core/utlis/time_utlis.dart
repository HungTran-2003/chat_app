import 'package:chat_app/generated/l10n.dart';

class TimeUtils {
  static String getTextTimeLastMessage(String? lastTime) {
    if (lastTime == null) {
      return '';
    }
    try {
      final messageTime = DateTime.parse(lastTime);
      final now = DateTime.now();
      final difference = now.difference(messageTime);
      if (difference.inSeconds < 60) {
        return S.current.common_time_just_now;
      } else if (difference.inMinutes < 60) {
        return S.current.common_time_minutes_ago(difference.inMinutes);
      } else if (now.year == messageTime.year &&
          now.month == messageTime.month &&
          now.day == messageTime.day) {
        final hour = messageTime.hour.toString().padLeft(2, '0');
        final minute = messageTime.minute.toString().padLeft(2, '0');
        return '$hour:$minute';
      } else if (difference.inDays < 7 && now.weekday > messageTime.weekday) {
        switch (messageTime.weekday) {
          case DateTime.monday:
            return S.current.common_time_weekday_monday;
          case DateTime.tuesday:
            return S.current.common_time_weekday_tuesday;
          case DateTime.wednesday:
            return S.current.common_time_weekday_wednesday;
          case DateTime.thursday:
            return S.current.common_time_weekday_thursday;
          case DateTime.friday:
            return S.current.common_time_weekday_friday;
          case DateTime.saturday:
            return S.current.common_time_weekday_saturday;
          case DateTime.sunday:
            return S.current.common_time_weekday_sunday;
          default:
            return '';
        }
      } else {
        final day = messageTime.day.toString().padLeft(2, '0');
        final month = messageTime.month.toString().padLeft(2, '0');
        if (now.year == messageTime.year) {
          return '$day/$month';
        } else {
          return '$day/$month/${messageTime.year}';
        }
      }
    } catch (e) {
      return '';
    }
  }
}
