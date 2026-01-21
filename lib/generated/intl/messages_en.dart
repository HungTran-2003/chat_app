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
    "common_app_title": MessageLookupByLibrary.simpleMessage("Chatbox"),
    "common_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "common_create_account": MessageLookupByLibrary.simpleMessage(
      "Create an account",
    ),
    "common_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Forgot password?",
    ),
    "common_have_account_login": MessageLookupByLibrary.simpleMessage(
      "Existing account? <Log in>",
    ),
    "common_label_name": MessageLookupByLibrary.simpleMessage("Your name"),
    "common_password": MessageLookupByLibrary.simpleMessage("Password"),
    "common_sign_in": MessageLookupByLibrary.simpleMessage("Login"),
    "common_sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
    "common_sign_up_with_email": MessageLookupByLibrary.simpleMessage(
      "Sign up with email",
    ),
    "common_your_email": MessageLookupByLibrary.simpleMessage("Your email"),
    "onboard_app_title": MessageLookupByLibrary.simpleMessage(
      "Connect friends <easily & quickly>",
    ),
    "onboard_description": MessageLookupByLibrary.simpleMessage(
      "Our chat app is the perfect way to stay connected with friends and family.",
    ),
  };
}
