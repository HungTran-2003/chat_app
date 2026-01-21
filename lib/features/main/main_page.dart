import 'package:chat_app/core/global/app_cubit/app_cubit.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/utlis/tap_guard.dart';
import 'package:chat_app/data/enum/main_nav_item.dart';
import 'package:chat_app/features/call/call_page.dart';
import 'package:chat_app/features/contact/contact_page.dart';
import 'package:chat_app/features/main/main_cubit.dart';
import 'package:chat_app/features/main/main_navigator.dart';
import 'package:chat_app/features/main/widget/tab_icon.dart';
import 'package:chat_app/features/message/message_page.dart';
import 'package:chat_app/features/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainCubit(navigator: MainNavigator(context: context));
      },
      child: const _MainChildPage(),
    );
  }
}

class _MainChildPage extends StatefulWidget {
  const _MainChildPage();

  @override
  State<_MainChildPage> createState() => _MainChildPageState();
}

class _MainChildPageState extends State<_MainChildPage> {
  late AppCubit _appCubit;
  late PageController _pageController;

  List<MainNavItem> get _navItems => [
    MainNavItem.message,
    MainNavItem.call,
    MainNavItem.contact,
    MainNavItem.setting,
  ];

  final List<Widget> _pages = [
    const MessagePage(),
    const CallPage(),
    const ContactPage(),
    const SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
    _appCubit = BlocProvider.of(context);
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppCubit, AppState>(
        listenWhen: (previous, current) =>
            previous.currentMainPage != current.currentMainPage,
        listener: (context, state) {
          _pageController.jumpToPage(_navItems.indexOf(state.currentMainPage!));
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    final bottomNavHeight = MediaQuery.of(context).padding.bottom + 90;
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) =>
          previous.currentMainPage != current.currentMainPage,
      builder: (context, state) {
        return Container(
          height: 108.0,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.borderBottomNav, width: 1.0),
            ),
          ),
          child: Container(
            height: 108.0,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(70.0),
                topRight: Radius.circular(70.0),
              ),
            ),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(MainNavItem.values.length, (index) {
                return InkWell(
                  onTap: () => safeAction(() {
                    _appCubit.changeMainPage(page: MainNavItem.values[index]);
                  }),
                  borderRadius: BorderRadius.circular(22),
                  child: TabIcons(
                    navItem: MainNavItem.values[index],
                    isSelected:
                        state.currentMainPage == MainNavItem.values[index],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
