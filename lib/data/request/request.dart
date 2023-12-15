class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(this.email, this.password, this.imei, this.deviceType);
}

class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest(this.email);
}

class RegisterRequest {
  String countryMobileCode;
  String name;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterRequest(
    this.countryMobileCode,
    this.name,
    this.email,
    this.password,
    this.mobileNumber,
    this.profilePicture,
  );
}
