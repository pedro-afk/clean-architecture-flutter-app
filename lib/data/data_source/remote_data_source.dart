import 'package:complete_advanced_flutter/data/network/app_api.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<SupportForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHome();
  Future<StoreDetailResponse> getStoreDetail();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      "12345", // loginRequest.imei,
      "XUXU", // loginRequest.deviceType,
    );
  }

  @override
  Future<SupportForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest loginRequest) async {
    return await _appServiceClient.forgotPassword(loginRequest.email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.countryMobileCode,
      registerRequest.name,
      registerRequest.email,
      registerRequest.password,
      registerRequest.mobileNumber,
      registerRequest.profilePicture,
    );
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }

  @override
  Future<StoreDetailResponse> getStoreDetail() async {
    return await _appServiceClient.getStoreDetail();
  }

}
