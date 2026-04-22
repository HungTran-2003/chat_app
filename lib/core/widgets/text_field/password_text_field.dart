import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final int? maxLines;
  final TextStyle? labelStyle;
  final FocusNode? focusNode;
  final EdgeInsets? padding;
  final TextStyle? style;
  final bool isObscure;
  final String? errorText;
  final VoidCallback? onToggleVisibility;
  final ValueChanged<bool>? onFocusChange;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const PasswordTextField({
    super.key,
    this.label = "TextField",
    this.controller,
    this.maxLines = 1,
    this.labelStyle,
    this.focusNode,
    this.padding,
    this.style,
    this.isObscure = true,
    this.errorText,
    this.onToggleVisibility,
    this.onFocusChange,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    widget.onFocusChange?.call(_focusNode.hasFocus);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    final defaultDecoration = InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: hasError ? AppColors.backgroundRed : AppColors.divider,
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: hasError ? AppColors.backgroundRed : AppColors.divider,
          width: 1,
        ),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          widget.isObscure ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: widget.onToggleVisibility,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "TextField",
          style:
          widget.labelStyle?.copyWith(
            color: hasError
                ? AppColors.backgroundRed
                : widget.labelStyle?.color,
          ) ??
              AppTextStyle.primary.s14.w600.copyWith(
                color: hasError ? AppColors.backgroundRed : AppColors.primary,
              ),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isObscure,
          maxLines: widget.maxLines,
          focusNode: _focusNode,
          decoration: defaultDecoration,
          style: widget.style ?? AppTextStyle.black.s18.w500,
          cursorColor: AppColors.primary,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
        SizedBox(
          height: 20,
          child: Text(
            hasError ? widget.errorText! : "",
            style: AppTextStyle.red.s14.w500,
          ),
        ),
      ],
    );
  }
}
