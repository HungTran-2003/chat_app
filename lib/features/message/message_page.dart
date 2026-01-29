import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/widgets/app_bar/base_app_bar.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/button/app_image_button.dart';
import 'package:chat_app/features/message/message_cubit.dart';
import 'package:chat_app/features/message/widget/contact_icon_widget.dart';
import 'package:chat_app/features/message/widget/home_button_status.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MessageCubit();
      },
      child: MessageChildPage(),
    );
  }
}

class MessageChildPage extends StatefulWidget {
  const MessageChildPage({super.key});

  @override
  State<MessageChildPage> createState() => _MessageChildPageState();
}

class _MessageChildPageState extends State<MessageChildPage> {
  late MessageCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.fetchData();
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
      action: AppImageButton(
        path: AssetConstants.userDefault,
        width: 44,
        height: 44,
        onPress: () {
          print("avatar");
        },
      ),
    );
  }

  Widget _buildBodyPage(){
    return Column(
      children: [
        40.height,
        _buildContactList(),
        40.height,
        Expanded(child: _buildListChat())
      ],
    );
  }

  Widget _buildContactList(){
    return Padding(
      padding: UiConstants.horizontalPaddingLarge,
      child: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 13.0,
              children: [
                HomeButtonStatus(),
                ...List.generate(
                  state.contacts!.length,
                  (index) {
                    final user = state.contacts![index].users?.last;
                    return ContactIconWidget(
                      user: user,
                    );
                  }
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildListChat(){
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: AppColors.backgroundLight,
        ),
      ),
    );
  }

}
