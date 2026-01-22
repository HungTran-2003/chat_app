import 'dart:math';

import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeButtonStatus extends StatelessWidget {
  final String? avatarPath;
  final double? size;

  const HomeButtonStatus({super.key, this.avatarPath, this.size = 58.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size!, size!),
                painter: SegmentPainter(),
              ),
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(AssetConstants.userDefault),
              ),
            ],
          ),
        ),
        10.height,
        Text(
          S.of(context).common_my_status,
          style: AppTextStyle.white.titleMedium.w500,
        )
      ],
    );
  }
}

class SegmentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 2.0;
    final Rect rect = Offset.zero & size;
    final double startAngle = 3.88 * pi / 3;
    final double gap = 0.2;


    final int segmentCount = 4;
    final double totalGap = gap * segmentCount;
    final double segmentAngle = (2 * pi - totalGap) / segmentCount;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < segmentCount; i++) {
      paint.color = (i == 0) ? Colors.white : AppColors.tertiary;

      double currentStartAngle = startAngle + i * (segmentAngle + gap);

      canvas.drawArc(
          rect.deflate(strokeWidth / 2),
          currentStartAngle,
          segmentAngle,
          false,
          paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
