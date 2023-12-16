import 'dart:async';

import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/domain/usecase/home_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;

  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    getHome();
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  Future<void> getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullscreenLoadingState));
    (await _homeUseCase.execute()).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullscreenErrorState, failure.message));
    }, (data) {
      inputState.add(ContentState());
      inputHomeData.add(
        HomeViewObject(data.data.stores, data.data.services, data.data.banners),
      );
    });
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((event) => event);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
