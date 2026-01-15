import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppTextRich extends StatelessWidget {
  final String rawText;
  final TextStyle? defaultStyle;
  final List<TextStyle> styles;
  final List<VoidCallback?>? onPress;

  const AppTextRich({
    super.key,
    required this.rawText,
    this.defaultStyle,
    this.styles = const [],
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];

    final RegExp regex = RegExp(r'<([^>]+)>');

    int lastMatchEnd = 0;
    int styleIndex = 0;

    final Iterable<RegExpMatch> matches = regex.allMatches(rawText);

    for (final RegExpMatch match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: rawText.substring(lastMatchEnd, match.start),
          style: defaultStyle,
        ));
      }

      String taggedText = match.group(1) ?? "";

      TextStyle currentStyle = (styleIndex < styles.length)
          ? styles[styleIndex]
          : (defaultStyle ?? AppTextStyle.white.titleMedium);

      VoidCallback? currentOnPress = (onPress != null && styleIndex < onPress!.length)
          ? onPress![styleIndex]
          : null;

      spans.add(TextSpan(
        text: taggedText,
        style: currentStyle,
        recognizer: currentOnPress != null
            ? (TapGestureRecognizer()..onTap = currentOnPress)
            : null,
      ));

      lastMatchEnd = match.end;
      styleIndex++;
    }

    if (lastMatchEnd < rawText.length) {
      spans.add(TextSpan(
        text: rawText.substring(lastMatchEnd),
        style: defaultStyle,
      ));
    }
    return Text.rich(
      TextSpan(children: spans),
    );
  }
}
