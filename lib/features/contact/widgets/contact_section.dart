import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/data/models/contact_entity.dart';
import 'package:chat_app/features/contact/widgets/contact_list_item.dart';
import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  final String title;
  final List<ContactEntity> contacts;

  const ContactSection({
    super.key,
    required this.title,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: UiConstants.horizontalPaddingLarge,
            child: Text(
              title,
              style: AppTextStyle.black.titleMedium.bold,
            ),
          ),
        ),
        SliverList.builder(
          itemCount: contacts.length,
          itemBuilder: (_, index) {
            return ContactListItem(user: contacts[index].user!);
          },
        ),
      ],
    );
  }
}
