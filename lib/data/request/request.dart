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