import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/button/app_button_wrapper.dart';
import 'package:chat_app/core/widgets/button/app_filled_button.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ContactRequestItem extends StatelessWidget {
  final ContactEntity contact;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onIgnore;

  const ContactRequestItem({
    super.key,
    required this.contact,
    this.onTap,
    this.onAccept,
    this.onIgnore,
  });

  @override
  Widget build(BuildContext context) {
    return AppButtonWrapper(
      onPressed: onTap,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteF3F5F9,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppAvatarImage(
                  path: contact.avatarUrl,
                ),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.username ?? '',
                        style: AppTextStyle.black.s18.w700,
                      ),
                      4.height,
                      Text(
                        contact.greetingMessage ?? '',
                        style: AppTextStyle.grey.s14.w400.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      8.height,
                      Text(
                        _getTimeAgo(context, contact.updateAt),
                        style: AppTextStyle.grey.s12.w700.copyWith(
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            20.height,
            AppFilledButton(
              label: S.of(context).common_accept,
              onPress: onAccept ?? () {},
              borderRadius: 30,
              backgroundColor: AppColors.primary,
              height: 52,
            ),
            12.height,
            AppFilledButton(
              label: S.of(context).common_ignore,
              onPress: onIgnore ?? () {},
              borderRadius: 30,
              backgroundColor: AppColors.redC64F00,
              height: 52,
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(BuildContext context, DateTime? dateTime) {
    if (dateTime == null) return S.of(context).common_sent_just_now;
    final diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 0) {
      final unit = diff.inDays == 1 ? S.of(context).common_day : S.of(context).common_days;
      return S.of(context).common_sent_time_ago(diff.inDays, unit);
    } else if (diff.inHours > 0) {
      final unit = diff.inHours == 1 ? S.of(context).common_hour : S.of(context).common_hours;
      return S.of(context).common_sent_time_ago(diff.inHours, unit);
    } else if (diff.inMinutes > 0) {
      final unit = diff.inMinutes == 1 ? S.of(context).common_minute : S.of(context).common_minutes;
      return S.of(context).common_sent_time_ago(diff.inMinutes, unit);
    } else {
      return S.of(context).common_sent_just_now;
    }
  }
}
