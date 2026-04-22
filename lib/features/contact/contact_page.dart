import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/app_bar/base_app_bar.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/loading/app_loading_overlay.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/features/contact/contact_cubit.dart';
import 'package:chat_app/features/contact/contact_navigator.dart';
import 'package:chat_app/features/contact/widgets/contact_section.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ContactCubit(navigator: ContactNavigator(context: context));
      },
      child: const ContactChildPage(),
    );
  }
}

class ContactChildPage extends StatefulWidget {
  const ContactChildPage({super.key});

  @override
  State<ContactChildPage> createState() => _ContactChildPageState();
}

class _ContactChildPageState extends State<ContactChildPage> {

  late ContactCubit _contactCubit;

  @override
  void initState() {
    _contactCubit = BlocProvider.of<ContactCubit>(context);
    _contactCubit.fetchData();
    super.initState();
  }

  Map<String, List<UserEntity>> groupUsersByFirstChar(
    List<ContactEntity> contacts,
  ) {
    final Map<String, List<UserEntity>> result = {};

    for (final contacts in contacts) {

    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBodyPage(),
      backgroundColor: AppColors.backgroundDark,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return BaseAppBar(
      title: S.of(context).common_home,
      leading: AppIconButton(
        path: AssetConstants.iconSearch,
        borderColor: AppColors.tertiary,
      ),
      action: AppIconButton(
        path: AssetConstants.iconUserPlus,
        borderColor: AppColors.tertiary,
        onPress: (){
          _contactCubit.navigator.openAddContactPage();
        },
      ),
    );
  }

  Widget _buildBodyPage() {
    return BlocListener<ContactCubit, ContactState>(
      listenWhen: (previous, current) =>
      previous.loadDataStatus != current.loadDataStatus,
      listener: (context, state) {
        if(state.loadDataStatus!.isLoading){
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
      },
      child: Column(
        children: [
          30.height,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: AppColors.backgroundLight,
              ),
              child: _buildContactList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList() {
    return Column(
      children: [
        13.height,
        Container(
          height: 3,
          width: 30,
          decoration: BoxDecoration(
            color: AppColors.greyCD,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Expanded(
          child: BlocBuilder<ContactCubit, ContactState>(
            builder: (context, state) {
              if (state.contacts!.isEmpty) {
                return Center(
                  child: Text("No data", style: AppTextStyle.black.titleLarge),
                );
              }
              final groupedContacts = groupUsersByFirstChar(state.contacts!);
              return CustomScrollView(
                slivers: [
                  for (final entry in groupedContacts.entries)
                    ContactSection(title: entry.key, users: entry.value),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
