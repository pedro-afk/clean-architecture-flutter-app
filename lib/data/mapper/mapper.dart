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

extension ServicesResponseMapper on ServiceResponse {
  Service toDomain() {
    return Service(id.orZero(), title.orEmpty(), image.orEmpty());
  }
}

extension StoresResponseMapper on StoreResponse {
  Store toDomain() {
    return Store(id.orZero(), title.orEmpty(), image.orEmpty());
  }
}

extension BannersResponseMapper on BannerResponse {
  BannerAd toDomain() {
    return BannerAd(id.orZero(), title.orEmpty(), image.orEmpty());
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices =
        (this?.data?.services.map((e) => e.toDomain()) ??
                const Iterable.empty())
            .cast<Service>()
            .toList();
    List<Store> mappedStores =
        (this?.data?.stores.map((e) => e.toDomain()) ?? const Iterable.empty())
            .cast<Store>()
            .toList();
    List<BannerAd> mappedBanners =
        (this?.data?.banners.map((e) => e.toDomain()) ?? const Iterable.empty())
            .cast<BannerAd>()
            .toList();
    var data = HomeData(mappedServices, mappedStores, mappedBanners);
    return HomeObject(data);
  }
}

extension StoreDetailResponseMapper on StoreDetailResponse {
  StoreDetail toDomain() {
    return StoreDetail(
      id,
      title,
      image,
      details,
      services,
      about,
    );
  }
}
