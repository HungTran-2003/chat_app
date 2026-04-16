import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/app_bar/base_app_bar.dart';
import 'package:chat_app/core/widgets/loading/app_loading_widget.dart';
import 'package:chat_app/core/widgets/text_field/app_outline_text_field.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/features/search/add_contact/add_contact_cubit.dart';
import 'package:chat_app/features/search/add_contact/add_contact_navigator.dart';
import 'package:chat_app/features/search/add_contact/widgets/contact_request_item.dart';
import 'package:chat_app/features/search/widgets/user_search_item.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AddContactCubit(
          navigator: AddContactNavigator(context: context),
          contactRepo: context.read(),
        );
      },
      child: const AddContactChildPage(),
    );
  }
}

class AddContactChildPage extends StatefulWidget {
  const AddContactChildPage({super.key});

  @override
  State<AddContactChildPage> createState() => _AddContactChildPageState();
}

class _AddContactChildPageState extends State<AddContactChildPage> {
  late AddContactCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    _cubit.initFetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.of(context).common_add_contact,
        titleStyle: AppTextStyle.black.titleLarge,
      ),
      body: _buildBodyPage(),
      backgroundColor: AppColors.backgroundLight,
    );
  }

  Widget _buildBodyPage(){
    return Column(
      spacing: 20,
      children: [
        _buildSearchInput(),
        Expanded(child: _buildListContact())
      ],
    );
  }

  Widget _buildListContact() {
    return BlocBuilder<AddContactCubit, AddContactState>(
      buildWhen: (pre, cur) =>
          pre.loadRequestStatus != cur.loadRequestStatus ||
          pre.loadDataStatus != cur.loadDataStatus ||
          pre.searchContacts != cur.searchContacts,
      builder: (context, state) {
        if (state.loadDataStatus?.isLoading == true ||
            state.loadRequestStatus?.isLoading == true) {
          return const Center(child: AppLoadingWidget());
        }
        if (state.users.isEmpty && state.contacts.isEmpty) {
          return Center(child: Text("No data"));
        }
        if (state.users.isEmpty) {
          return ListView.builder(
            itemCount: state.searchContacts.length,
            itemBuilder: (context, index) {
              return ContactRequestItem(
                contact: state.searchContacts[index],
                onTap: () {
                  print("onTap");
                },
                onAccept: () {
                  print("onAccept");
                },
                onDecline: () {
                  print("onDecline");
                },
              );
            },
          );
        }
        return ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            return UserSearchItem(user: state.users[index]);
          },
        );
      },
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedBuilder(
        animation: _cubit.searchController,
        builder: (context, _) {
          return AppOutlineTextField(
            controller: _cubit.searchController,
            hint: S.of(context).common_search,
            prefixIcon: const Icon(Icons.search, color: AppColors.tertiary),
            borderRadius: 30,
            onChanged: (value) => _cubit.search(value),
            suffixIcon: _cubit.searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.cancel, color: AppColors.tertiary, size: 20),
                    onPressed: () {
                      _cubit.searchController.clear();
                      _cubit.search("");
                    },
                  )
                : null,
          );
        },
      ),
    );
  }

}
