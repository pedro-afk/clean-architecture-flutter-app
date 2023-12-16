import 'dart:async';

import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers
  final StreamController _streamController = StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView(); // send slider data to view
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) _currentIndex = 0;
    return _currentIndex;
  }

  @override
  int goPrevius() {
    int previusIndex = _currentIndex--;
    if (previusIndex == -1) _currentIndex = _list.length - 1;
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    // when currentIndex changed will send a new object to view
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(
        _list[_currentIndex],
        _list.length,
        _currentIndex,
      ),
    );
  }

  static List<SliderObject> _getSliderData() => [
    SliderObject(AppStrings.onBoardingTitle1.tr(),
        AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2.tr(),
        AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onBoardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3.tr(),
        AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onBoardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4,
        AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onBoardingLogo4),
  ];
}

// inputs mean the orders that view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext(); // when clicks on right arrow or swipe left
  int goPrevius(); // when clicks on left arrow or swipe right
  void onPageChanged(int index);

  Sink get inputSliderViewObject; // way to add data to the stream ..stream input
}

// outputs mean data or results tha will be sent from view model to view
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}