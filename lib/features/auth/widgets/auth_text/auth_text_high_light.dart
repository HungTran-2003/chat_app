import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthTextHighLight extends StatelessWidget {
  final String rawText;
  final TextStyle? defaultStyle;
  final List<TextStyle> styles;
  final Color? highLightColor;
  final double? highlightHeight;

  const AuthTextHighLight({
    super.key,
    required this.rawText,
    this.defaultStyle,
    this.styles = const [],
    this.highLightColor = AppColors.highlightGreen,
    this.highlightHeight = 8,
  });

  @override
  Widget build(BuildContext context) {
    final RegExp regex = RegExp(r'<([^>]+)>');
    final Iterable<RegExpMatch> matches = regex.allMatches(rawText);

    if (matches.isEmpty) {
      return Text(rawText, style: defaultStyle ?? AppTextStyle.black.s18.bold);
    }

    final List<InlineSpan> spans = [];
    int lastMatchEnd = 0;
    int styleIndex = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: rawText.substring(lastMatchEnd, match.start)));
      }

      final String highlightedText = match.group(1)!;
      final TextStyle styleToApply =
          (styles.isNotEmpty && styleIndex < styles.length)
          ? styles[styleIndex]
          : defaultStyle ?? AppTextStyle.black.s18.bold;

      spans.add(
        WidgetSpan(
          child: _buildHighLight(highlightedText, styleToApply),
          alignment: PlaceholderAlignment.middle,
        ),
      );

      lastMatchEnd = match.end;
      styleIndex++;
    }

    if (lastMatchEnd < rawText.length) {
      spans.add(TextSpan(text: rawText.substring(lastMatchEnd)));
    }

    return Text.rich(
      TextSpan(
        style: defaultStyle ?? AppTextStyle.black.s18.bold,
        children: spans,
      ),
    );
  }

  Widget _buildHighLight(String text, TextStyle style) {
    return IntrinsicWidth(
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: highlightHeight, color: highLightColor),
          ),
          Text(text, style: style),
        ],
      ),
    );
  }
}
