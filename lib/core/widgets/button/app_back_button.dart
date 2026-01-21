import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/global/app_cubit/app_cubit.dart';
import 'package:chat_app/core/widgets/image/app_svg_image.dart';
import 'package:chat_app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  final String? fallbackRoute;
  final bool Function()? isShowValidateDialog;
  final Future<void> Function()? beforeBackAction;

  const AppBackButton({
    super.key,
    this.fallbackRoute,
    this.isShowValidateDialog,
    this.beforeBackAction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await beforeBackAction?.call();
        final shouldShowDialog = isShowValidateDialog?.call() ?? false;
        if (!context.mounted) return;
        if (shouldShowDialog) {
          // shouldShowDialogAppDialog(context).showUnsaveEditDialog();
        } else {
          _safePop(context);
        }
      },
      child: Container(
        height: 48,
        padding: UiConstants.paddingSmall.paddingAll,
        child: const AppSvgImage(
          AssetConstants.backIcon,
          height: 8,
          width: 12,
        ),
      ),
    );
  }

  void _safePop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      try {
        final appCubit = context.read<AppCubit>();
        // appCubit.changeMainPage(page: MainNavItem.home);
        context.goNamed(AppRouter.homeRouterName);
      } catch (e) {
        context.goNamed(AppRouter.homeRouterName);
      }
    }
  }
}
