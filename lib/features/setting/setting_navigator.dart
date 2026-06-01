import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/navigation/app_router.dart';

class SettingNavigator extends BaseNavigator {
  SettingNavigator({required super.context});

  void openEditProfilePage() {
    pushNamed(AppRouter.editProfileRouterName);
  }
}