import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numOfNotifications')
  int? numOfNotifications;

  CustomerResponse(this.id, this.name, this.numOfNotifications);
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'link')
  String? link;

  ContactsResponse(this.email, this.phone, this.link);
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class SupportForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  SupportForgotPasswordResponse(this.support);
  factory SupportForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$SupportForgotPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SupportForgotPasswordResponseToJson(this);
}

abstract class BaseDataResponse {
  int? id;
  String? title;
  String? image;

  BaseDataResponse(this.id, this.title, this.image);
}

@JsonSerializable()
class ServiceResponse extends BaseDataResponse {
  ServiceResponse(super.id, super.title, super.image);
  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class StoreResponse extends BaseDataResponse {
  StoreResponse(super.id, super.title, super.image);
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class BannerResponse extends BaseDataResponse {
  BannerResponse(super.id, super.title, super.image);
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "services")
  List<ServiceResponse> services;
  @JsonKey(name: "stores")
  List<StoreResponse> stores;
  @JsonKey(name: "banners")
  List<BannerResponse> banners;

  HomeDataResponse(this.services, this.stores, this.banners);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "data")
  HomeDataResponse? data;

  HomeResponse(this.data);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}
