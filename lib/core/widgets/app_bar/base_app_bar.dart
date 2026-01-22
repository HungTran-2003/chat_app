import 'package:chat_app/core/configs/app_configs.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/button/app_back_button.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Widget? action;
  final bool? showLeadingButton;
  final TextStyle? titleStyle;

  const BaseAppBar({
    super.key,
    required this.title,
    this.leading,
    this.action,
    this.showLeadingButton = true,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if(showLeadingButton == true) leading?? AppBackButton(),
          Text(
            title,
            style: titleStyle ?? AppTextStyle.white.titleLarge,
          ),
          action ?? 44.width,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConfigs.appBarHeight);
}
