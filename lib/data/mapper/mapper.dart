// convert the response into a non nullable object (model)
// convert data layer object to domain layer object

import 'package:complete_advanced_flutter/app/extension.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';

const empty = "";
const zero = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? empty,
      this?.name?.orEmpty() ?? empty,
      this?.numOfNotifications?.orZero() ?? zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email?.orEmpty() ?? empty,
      this?.phone?.orEmpty() ?? empty,
      this?.link?.orEmpty() ?? empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer?.toDomain(),
      this?.contacts?.toDomain(),
    );
  }
}

extension SupportForgotPasswordResponseMapper on SupportForgotPasswordResponse {
  SupportForgotPassword toDomain() {
    return SupportForgotPassword(support);
  }
}