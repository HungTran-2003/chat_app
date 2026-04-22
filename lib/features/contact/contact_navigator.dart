import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/navigation/app_router.dart';

class ContactNavigator extends BaseNavigator {
  ContactNavigator({required super.context});

  void openAddContactPage(){
    pushNamed(AppRouter.searchAddContactRouterName);

  }
}