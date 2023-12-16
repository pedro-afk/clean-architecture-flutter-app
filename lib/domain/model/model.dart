class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String email;
  String phone;
  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}

class SupportForgotPassword {
  String? support;

  SupportForgotPassword(this.support);
}

abstract class BaseData {
  int id;
  String title;
  String image;

  BaseData(this.id, this.title, this.image);
}

class Service extends BaseData {
  Service(super.id, super.title, super.image);
}

class Store extends BaseData {
  Store(super.id, super.title, super.image);
}

class BannerAd extends BaseData {
  BannerAd(super.id, super.title, super.image);
}

class HomeData {
  List<Service> services;
  List<Store> stores;
  List<BannerAd> banners;

  HomeData(this.services, this.stores, this.banners);
}

class HomeObject {
  HomeData data;

  HomeObject(this.data);
}

class StoreDetail {
  int? id;
  String? title;
  String? image;
  String? details;
  String? services;
  String? about;

  StoreDetail(
    this.id,
    this.title,
    this.image,
    this.details,
    this.services,
    this.about,
  );
}
