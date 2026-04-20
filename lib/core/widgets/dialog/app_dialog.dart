import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/button/app_filled_button.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';

enum DialogType {
  infoAlert, // Informational dialog with a single button (e.g., "OK")
  infoConfirmation, // Informational confirmation dialog with actions (e.g., "OK" / "Cancel")
  errorAlert, // Error dialog with a single button
  errorConfirmation, // Error confirmation dialog with actions (e.g., "Yes" / "No")
}

extension DialogTypeExt on DialogType {
  bool get isDeclinedButtonVisible {
    switch (this) {
      case DialogType.infoAlert:
        return false; // No decline button for info alert
      case DialogType.infoConfirmation:
        return true; // Decline button is visible
      case DialogType.errorAlert:
        return false; // No decline button for error alert
      case DialogType.errorConfirmation:
        return true; // Decline button is visible
    }
  }

  Color getConfirmButtonColor(BuildContext context) {
    switch (this) {
      case DialogType.infoAlert:
        return AppColors.primary;
      case DialogType.infoConfirmation:
        return AppColors.primary;
      case DialogType.errorAlert:
        return AppColors.backgroundRed;
      case DialogType.errorConfirmation:
        return AppColors.backgroundRed;
    }
  }
}

enum DialogAction {
  confirmed, // User has confirmed the action
  declined, // User has declined the action
  dismissed, // User has dismissed the dialog
}

class AppDialog {
  static Future<DialogAction> show({
    required BuildContext context,
    required DialogType dialogType,
    required String titleText,
    required String messageText,
    required String confirmButtonText,
    String declineButtonText = "",
    Widget? headerIcon,
    double? buttonRadius,
  }) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.backgroundDark, // Light mode
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(24),
          ),
          backgroundColor: AppColors.backgroundLight,
          scrollable: true,
          title: Center(
            child: Text(
              titleText,
              style: AppTextStyle.black.s20.w700,
              textAlign: TextAlign.center,
            ),
          ),
          content: SizedBox(
            width: 328,
            child: messageText.isNotEmpty
                ? Text(
              messageText,
              style: AppTextStyle.grey.s14.w400,
              textAlign: TextAlign.center,
            )
                : null,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (dialogType.isDeclinedButtonVisible)
                  Expanded(
                    flex: 1,
                    child: AppFilledButton(
                      label: declineButtonText,
                      borderRadius: buttonRadius,
                      backgroundColor: AppColors.whiteF3F6F6,
                      labelStyle: AppTextStyle.grey.s16.w700,
                      onPress: () {
                        Navigator.of(context).pop(DialogAction.declined);
                      },
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: AppFilledButton(
                    label: confirmButtonText,
                    borderRadius: buttonRadius,
                    labelStyle: AppTextStyle.white.s16.w700.copyWith(
                      color: dialogType == DialogType.errorConfirmation
                          ? AppColors.whiteF3F6F6
                          : AppColors.backgroundDark,
                    ),
                    onPress: () {
                      Navigator.of(context).pop(DialogAction.confirmed);
                    },
                    backgroundColor: dialogType.getConfirmButtonColor(context),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (result is DialogAction) {
      return result;
    }
    return DialogAction.dismissed;
  }

  static Future<DialogAction> showCustom({
    required BuildContext context,
    required DialogType dialogType,
    required Widget content,
    required String confirmButtonText,
    String? declineButtonText,
    double? buttonRadius,
  }) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.backgroundDark, // Light mode
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(24),
          ),
          backgroundColor: AppColors.backgroundLight,
          scrollable: true,
          content: SizedBox(
              width: 328,
              child: content
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (dialogType.isDeclinedButtonVisible)
                  Expanded(
                    flex: 1,
                    child: AppFilledButton(
                      label: declineButtonText ?? S.of(context).common_cancel,
                      borderRadius: buttonRadius,
                      backgroundColor: AppColors.whiteF3F6F6,
                      labelStyle: AppTextStyle.grey.s16.w700,
                      onPress: () {
                        Navigator.of(context).pop(DialogAction.declined);
                      },
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: AppFilledButton(
                    label: confirmButtonText,
                    borderRadius: buttonRadius,
                    labelStyle: AppTextStyle.white.s16.w700.copyWith(
                      color: dialogType == DialogType.errorConfirmation
                          ? AppColors.whiteF3F6F6
                          : AppColors.backgroundDark,
                    ),
                    onPress: () {
                      Navigator.of(context).pop(DialogAction.confirmed);
                    },
                    backgroundColor: dialogType.getConfirmButtonColor(context),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (result is DialogAction) {
      return result;
    }
    return DialogAction.dismissed;
  }
}
