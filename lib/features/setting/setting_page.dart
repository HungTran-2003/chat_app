import 'package:chat_app/core/global/user/user_cubit.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/features/setting/setting_cubit.dart';
import 'package:chat_app/features/setting/setting_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (context) => SettingCubit(SettingNavigator(context: context)),
      child: const SettingChildPage(),
    );
  }
}

class SettingChildPage extends StatefulWidget {
  const SettingChildPage({super.key});

  @override
  State<SettingChildPage> createState() => _SettingChildPageState();
}

class _SettingChildPageState extends State<SettingChildPage> {
  late SettingCubit _cubit;
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = BlocProvider.of<UserCubit>(context);
    _cubit = BlocProvider.of<SettingCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- Custom Premium Top App Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balancing width for centered title
                ],
              ),
            ),
            const SizedBox(height: 12),
            // --- White Rounded Overlapping Card Container ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(36),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(36),
                  ),
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, userState) {
                      final user = userState.user;

                      return ListView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          // --- Bottom Sheet style Handle Pill ---
                          Center(
                            child: Container(
                              width: 36,
                              height: 4,
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5E5E5),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // --- User Profile Header ---
                          InkWell(
                            onTap: () {
                              _cubit.navigator.openEditProfilePage();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  AppAvatarImage(
                                    path: user?.avatarPath,
                                    size: 60,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user?.userName ?? "Nazrul Islam",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textBlack,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          user?.slogan ?? "Never give up 💪",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.tertiary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Circular Scan/QR Icon Container
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.08),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.qr_code_scanner_rounded,
                                      color: AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Divider(
                              color: Color(0xFFF3F6F6),
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // --- Settings Items ---
                          _buildSettingsItem(
                            icon: Icons.key_outlined,
                            title: "Account",
                            subtitle: "Privacy, security, change number",
                            onTap: () {
                              // Account actions
                            },
                          ),
                          _buildSettingsItem(
                            icon: Icons.chat_bubble_outline_rounded,
                            title: "Chat",
                            subtitle: "Chat history, theme, wallpapers",
                            onTap: () {
                              // Chat settings
                            },
                          ),
                          _buildSettingsItem(
                            icon: Icons.notifications_none_rounded,
                            title: "Notifications",
                            subtitle: "Messages, group and others",
                            onTap: () {
                              // Notification settings
                            },
                          ),
                          _buildSettingsItem(
                            icon: Icons.help_outline_rounded,
                            title: "Help",
                            subtitle: "Help center, contact us, privacy policy",
                            onTap: () {
                              // Help settings
                            },
                          ),
                          _buildSettingsItem(
                            icon: Icons.swap_vert_rounded,
                            title: "Storage and data",
                            subtitle: "Network usage, storage usage",
                            onTap: () {
                              // Storage settings
                            },
                          ),
                          _buildSettingsItem(
                            icon: Icons.person_add_alt_1_outlined,
                            title: "Invite a friend",
                            subtitle: "Share the app with your circle",
                            onTap: () {
                              // Invite actions
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Divider(
                              color: Color(0xFFF3F6F6),
                              height: 1,
                            ),
                          ),
                          // --- Log Out Action ---
                          _buildSettingsItem(
                            icon: Icons.logout_rounded,
                            title: "Log out",
                            subtitle: "Sign out from your chat session safely",
                            iconColor: Colors.red[700]!,
                            titleColor: Colors.red[700]!,
                            onTap: () async {
                              _showLogOutConfirmationDialog();
                            },
                          ),
                          const SizedBox(height: 40),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF797C7B),
    Color titleColor = AppColors.textBlack,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFF3F6F6),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogOutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Đăng xuất"),
          content: const Text("Bạn có chắc chắn muốn đăng xuất khỏi tài khoản của mình?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _userCubit.logOut();
                _cubit.navigator.openLoginPage();
              },
              child: const Text(
                "Đăng xuất",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
