// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count, unit) => "SENT ${count} ${unit} AGO";

  static String m1(count) => "${count}m ago";

  static String m2(userName) =>
      "Add ${userName} now to start chatting with them";

  static String m3(userName) => "add ${userName} to your contact list";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "auth_login_description": MessageLookupByLibrary.simpleMessage(
      "Welcome back! Sign in using your social account or email to continue us",
    ),
    "auth_login_title": MessageLookupByLibrary.simpleMessage(
      "<Log in> to Chatbox",
    ),
    "auth_register_description": MessageLookupByLibrary.simpleMessage(
      "Get chatting with friends and family today by signing up for our chat app!",
    ),
    "auth_register_title": MessageLookupByLibrary.simpleMessage(
      "Sign up with <Email>",
    ),
    "chat_empty_inside": MessageLookupByLibrary.simpleMessage(
      "Hai bạn chưa có tin nhắn nào. Hãy gửi một lời chào để bắt đầu cuộc trò chuyện 👋",
    ),
    "chat_empty_outside": MessageLookupByLibrary.simpleMessage(
      "Hai bạn chưa có tin nhắn nào. Hãy bắt đầu trò chuyện",
    ),
    "common_accept": MessageLookupByLibrary.simpleMessage("Accept Request"),
    "common_add_contact": MessageLookupByLibrary.simpleMessage("Add contact"),
    "common_app_title": MessageLookupByLibrary.simpleMessage("Chatbox"),
    "common_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "common_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "common_contact": MessageLookupByLibrary.simpleMessage("Contacts"),
    "common_create_account": MessageLookupByLibrary.simpleMessage(
      "Create an account",
    ),
    "common_day": MessageLookupByLibrary.simpleMessage("DAY"),
    "common_days": MessageLookupByLibrary.simpleMessage("DAYS"),
    "common_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Forgot password?",
    ),
    "common_have_account_login": MessageLookupByLibrary.simpleMessage(
      "Existing account? <Log in>",
    ),
    "common_home": MessageLookupByLibrary.simpleMessage("Home"),
    "common_hour": MessageLookupByLibrary.simpleMessage("HOUR"),
    "common_hours": MessageLookupByLibrary.simpleMessage("HOURS"),
    "common_ignore": MessageLookupByLibrary.simpleMessage("Ignore"),
    "common_introduction": MessageLookupByLibrary.simpleMessage("Introduction"),
    "common_label_name": MessageLookupByLibrary.simpleMessage("Your name"),
    "common_message_data_already_exists": MessageLookupByLibrary.simpleMessage(
      "The data already exists.",
    ),
    "common_message_data_not_found": MessageLookupByLibrary.simpleMessage(
      "The requested data could not be found.",
    ),
    "common_message_invalid_data": MessageLookupByLibrary.simpleMessage(
      "The submitted data is invalid.",
    ),
    "common_message_invalid_email": MessageLookupByLibrary.simpleMessage(
      "The email address is invalid.",
    ),
    "common_message_network_error": MessageLookupByLibrary.simpleMessage(
      "Network connection error. Please check your internet connection.",
    ),
    "common_message_permission_denied": MessageLookupByLibrary.simpleMessage(
      "You do not have permission to perform this action.",
    ),
    "common_message_quota_exceeded": MessageLookupByLibrary.simpleMessage(
      "The system is temporarily overloaded. Please try again later.",
    ),
    "common_message_time_parsing_error": MessageLookupByLibrary.simpleMessage(
      "Time parsing error",
    ),
    "common_message_timeout": MessageLookupByLibrary.simpleMessage(
      "The request took too long to process. Please try again.",
    ),
    "common_message_unauthenticated": MessageLookupByLibrary.simpleMessage(
      "You need to sign in to continue.",
    ),
    "common_message_unexpected_error": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again later.",
    ),
    "common_message_user_disabled": MessageLookupByLibrary.simpleMessage(
      "This account has been disabled.",
    ),
    "common_message_user_not_found": MessageLookupByLibrary.simpleMessage(
      "User not found.",
    ),
    "common_message_wrong_password": MessageLookupByLibrary.simpleMessage(
      "Incorrect password.",
    ),
    "common_minute": MessageLookupByLibrary.simpleMessage("MINUTE"),
    "common_minutes": MessageLookupByLibrary.simpleMessage("MINUTES"),
    "common_my_status": MessageLookupByLibrary.simpleMessage("My status"),
    "common_password": MessageLookupByLibrary.simpleMessage("Password"),
    "common_result": MessageLookupByLibrary.simpleMessage("Result"),
    "common_retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "common_search": MessageLookupByLibrary.simpleMessage("Search"),
    "common_send": MessageLookupByLibrary.simpleMessage("Send"),
    "common_sent_just_now": MessageLookupByLibrary.simpleMessage(
      "SENT JUST NOW",
    ),
    "common_sent_time_ago": m0,
    "common_sign_in": MessageLookupByLibrary.simpleMessage("Login"),
    "common_sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
    "common_sign_up_with_email": MessageLookupByLibrary.simpleMessage(
      "Sign up with email",
    ),
    "common_time_just_now": MessageLookupByLibrary.simpleMessage("Just now"),
    "common_time_minutes_ago": m1,
    "common_time_weekday_friday": MessageLookupByLibrary.simpleMessage(
      "Friday",
    ),
    "common_time_weekday_monday": MessageLookupByLibrary.simpleMessage(
      "Monday",
    ),
    "common_time_weekday_saturday": MessageLookupByLibrary.simpleMessage(
      "Saturday",
    ),
    "common_time_weekday_sunday": MessageLookupByLibrary.simpleMessage(
      "Sunday",
    ),
    "common_time_weekday_thursday": MessageLookupByLibrary.simpleMessage(
      "Thursday",
    ),
    "common_time_weekday_tuesday": MessageLookupByLibrary.simpleMessage(
      "Tuesday",
    ),
    "common_time_weekday_wednesday": MessageLookupByLibrary.simpleMessage(
      "Wednesday",
    ),
    "common_your_email": MessageLookupByLibrary.simpleMessage("Your email"),
    "common_your_message": MessageLookupByLibrary.simpleMessage("Your message"),
    "contact_request_description": m2,
    "content_message_add_request": m3,
    "message_hint_your_message": MessageLookupByLibrary.simpleMessage(
      "Enter your message",
    ),
    "message_user_have_not_slogan": MessageLookupByLibrary.simpleMessage(
      "This guy is incredibly lazy.",
    ),
    "nav_call": MessageLookupByLibrary.simpleMessage("Call"),
    "nav_contact": MessageLookupByLibrary.simpleMessage("Contact"),
    "nav_message": MessageLookupByLibrary.simpleMessage("Message"),
    "nav_setting": MessageLookupByLibrary.simpleMessage("Setting"),
    "onboard_app_title": MessageLookupByLibrary.simpleMessage(
      "Connect friends <easily & quickly>",
    ),
    "onboard_description": MessageLookupByLibrary.simpleMessage(
      "Our chat app is the perfect way to stay connected with friends and family.",
    ),
    "title_contact_request": MessageLookupByLibrary.simpleMessage(
      "Contact Pending",
    ),
    "title_contact_request_detail": MessageLookupByLibrary.simpleMessage(
      "Contact Request Detail",
    ),
    "title_message_add_request": MessageLookupByLibrary.simpleMessage(
      "Send friend request",
    ),
  };
}
