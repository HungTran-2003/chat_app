import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/app_bar/base_app_bar.dart';
import 'package:chat_app/core/widgets/button/app_filled_button.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/core/widgets/loading/app_loading_overlay.dart';
import 'package:chat_app/core/widgets/loading/app_loading_widget.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/features/contact/contact_request_detail/contact_request_detail_cubit.dart';
import 'package:chat_app/features/contact/contact_request_detail/contact_request_detail_navigator.dart';
import 'package:chat_app/features/contact/contact_request_detail/contact_request_detail_state.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactRequestDetailArgument {
  final ContactEntity contact;

  ContactRequestDetailArgument({required this.contact});
}

class ContactRequestDetailPage extends StatelessWidget {
  final ContactRequestDetailArgument argument;
  const ContactRequestDetailPage({super.key, required this.argument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactRequestDetailCubit(
        navigator: ContactRequestDetailNavigator(context: context),
        userRepo: context.read(),
        contactRepo: context.read(),
        argument: argument,
      )..init(),
      child: const ContactRequestDetailChildPage(),
    );
  }
}

class ContactRequestDetailChildPage extends StatefulWidget {
  const ContactRequestDetailChildPage({super.key});

  @override
  State<ContactRequestDetailChildPage> createState() =>
      _ContactRequestDetailChildPageState();
}

class _ContactRequestDetailChildPageState
    extends State<ContactRequestDetailChildPage> {
  late final ContactRequestDetailCubit _cubit;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _l10n = S.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactRequestDetailCubit, ContactRequestDetailState>(
      listenWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus ||
          previous.overLayStatus != current.overLayStatus,
      listener: (context, state) {
        if (state.loadStatus.isError) {
          _cubit.navigator.showErrorDialog(message: state.errorMessage);
        } else if (state.overLayStatus.isLoading) {
          AppLoadingOverlay.show(context);
        } else if (state.overLayStatus.isSuccess) {
          AppLoadingOverlay.hide();
          _cubit.navigator.pop(true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: BaseAppBar(title: _l10n.title_contact_request_detail),
        body: _buildBodyPage(),
        floatingActionButton: BlocBuilder<ContactRequestDetailCubit, ContactRequestDetailState>(
          buildWhen: (previous, current) => previous.loadStatus != current.loadStatus,
          builder: (context, state) {
            if (!state.loadStatus.isSuccess) return const SizedBox.shrink();
            return FloatingActionButton(
              onPressed: () {
              },
              backgroundColor: AppColors.primary,
              shape: const CircleBorder(),
              child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBodyPage() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: BlocBuilder<ContactRequestDetailCubit, ContactRequestDetailState>(
        buildWhen: (previous, current) =>
            previous.loadStatus != current.loadStatus,
        builder: (context, state) {
          if (state.loadStatus.isLoading) {
            return const Center(child: AppLoadingWidget());
          }
          if (state.loadStatus.isError) {
            return Center(
              child: AppFilledButton(label: _l10n.common_retry, onPress: () {}),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildUserInfo(state.user!),
                24.height,
                _buildGreetingMessage(
                  _cubit.argument.contact.greetingMessage ?? "",
                ),
                24.height,
                _buildButton(),
                40.height,
                Text(
                  _l10n.contact_request_description(state.user!.userName ?? ""),
                  style: AppTextStyle.grey.s16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserInfo(UserEntity user) {
    return Column(
      children: [
        AppAvatarImage(path: user.avatarPath, size: 100),
        6.height,
        Text(user.userName ?? "", style: AppTextStyle.black.s20.w700),
        Text(
          user.slogan ?? _l10n.message_user_have_not_slogan,
          style: AppTextStyle.grey.s16.w700,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildGreetingMessage(String message) {
    if (message.isEmpty) return const SizedBox.shrink();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.greyCD),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            "\"$message\"",
            style: AppTextStyle.black.s18.w400.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.5,
              color: AppColors.backgroundDark.withAlpha(180),
            ),
          ),
        ),
        Positioned(
          top: -12,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _l10n.common_introduction,
              style: AppTextStyle.white.s16.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Row(
      children: [
        Expanded(
          child: AppFilledButton(
            label: S.of(context).common_accept,
            onPress: () =>
                _cubit.acceptRequest(requestId: _cubit.argument.contact.uid!),
            borderRadius: 30,
            backgroundColor: AppColors.primary,
            height: 52,
          ),
        ),
        12.width,
        Expanded(
          child: AppFilledButton(
            label: S.of(context).common_ignore,
            onPress: () =>
                _cubit.ignoreRequest(requestId: _cubit.argument.contact.uid!),
            borderRadius: 30,
            backgroundColor: AppColors.redC64F00,
            height: 52,
          ),
        ),
      ],
    );
  }
}
