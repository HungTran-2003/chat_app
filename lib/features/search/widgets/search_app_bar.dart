import 'package:chat_app/core/configs/app_configs.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final bool? isEnabled;
  final String? hintText;
  final FocusNode? focusNode;
  final VoidCallback? onSuffixIconPressed;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  
  const SearchAppBar({
    super.key,
    required this.controller,
    this.isEnabled = true,
    this.hintText,
    this.focusNode,
    this.onSuffixIconPressed,
    this.onSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: UiConstants.horizontalPaddingLarge,
        child: TextField(
          controller: controller,
          enabled: isEnabled,
          focusNode: focusNode,
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: onSuffixIconPressed,
              icon: Icon(Icons.close),
            ),
            fillColor: AppColors.whiteF3F6F6,
            filled: true,
          ),
          style: AppTextStyle.black.s12.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConfigs.appBarHeight);
}

