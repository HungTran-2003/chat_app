import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/image/app_svg_image.dart';
import 'package:chat_app/domain/models/enum/main_nav_item.dart';
import 'package:flutter/material.dart';

class TabIcons extends StatelessWidget {
  final MainNavItem navItem;
  final bool isSelected;

  const TabIcons({super.key, required this.navItem, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSvgImage(
          navItem.icon,
          width: 26,
          height: 26,
          colorFilter: isSelected == true
          ? ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          )
          : ColorFilter.mode(
            AppColors.tertiary,
            BlendMode.srcIn,
          ),
        ),
        Text(
          navItem.title,
          style: isSelected == true
          ? AppTextStyle.primary.w600
          : AppTextStyle.tertiary.w400,
        )
      ],
    );
  }
}