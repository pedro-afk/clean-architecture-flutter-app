import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}

@freezed
class ForgotPasswordObject with _$ForgotPasswordObject {
  factory ForgotPasswordObject(String email) = _ForgotPasswordObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String username, String password, String countryMobileCode, String mobileNumber, String email, String profilePicture) = _RegisterObject;
}
