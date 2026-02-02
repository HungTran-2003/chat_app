import 'dart:async';

import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/widgets/loading/app_loading_widget.dart';
import 'package:chat_app/data/enum/status_type.dart';
import 'package:chat_app/features/contact/widgets/contact_list_item.dart';
import 'package:chat_app/features/search/add_contact/add_contact_cubit.dart';
import 'package:chat_app/features/search/add_contact/add_contact_navigator.dart';
import 'package:chat_app/features/search/widgets/search_app_bar.dart';
import 'package:chat_app/features/search/widgets/user_search_item.dart';
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
          authRepository: context.read(),
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
  Timer? _debounce;
  late AddContactCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        controller: _cubit.searchController,
        focusNode: _cubit.searchFocusNode,
        onChanged: (value){
          _debounce?.cancel();
          _debounce = Timer(const Duration(seconds: 1), () {
            _cubit.searchUser(value);
          });
        },
        onSubmitted: (value){
        },
        onSuffixIconPressed: () {
          _cubit.searchController.clear();
          _cubit.searchFocusNode.unfocus();
        }
      ),
      body: BlocBuilder<AddContactCubit, AddContactState>(
        buildWhen: (pre, cur) => pre.loadDataStatus != cur.loadDataStatus,
        builder: (context, state) {
          if (state.loadDataStatus?.isLoading == true) {
            return const Center(child: AppLoadingWidget());
          }
          if (state.users!.isEmpty) {
            return Center(child: Text("No data"));
          }
          return ListView.builder(
            itemCount: state.users!.length,
            itemBuilder: (context, index) {
              return UserSearchItem(user: state.users![index]);
            },
          );
        },
      ),
      backgroundColor: AppColors.backgroundLight,
    );
  }
}
