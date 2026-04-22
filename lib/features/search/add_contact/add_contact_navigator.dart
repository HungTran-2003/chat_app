import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:chat_app/features/contact/contact_request_detail/contact_request_detail_page.dart';
import 'package:chat_app/navigation/app_router.dart';

class AddContactNavigator extends BaseNavigator {
  AddContactNavigator({required super.context});

  Future<bool?> navigatorToRequestDetail(ContactEntity contact) async {
    if (contact.requestId == null) {
      showErrorDialog(message: "Cannot find requestID");
      return null;
    }
    return await pushNamed(
      AppRouter.contactRequestDetailRouterName,
      extra: ContactRequestDetailArgument(contact: contact),
    );
  }
}
