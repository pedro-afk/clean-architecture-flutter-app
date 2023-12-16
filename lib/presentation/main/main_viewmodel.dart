import 'dart:async';

import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/main/home_page.dart';
import 'package:complete_advanced_flutter/presentation/main/notifications_page.dart';
import 'package:complete_advanced_flutter/presentation/main/settings_page.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'search_page.dart';

class MainViewModel extends BaseViewModel with MainViewModelInputs, MainViewModelOutputs {
  final _currentIndexController = StreamController<int>();

  @override
  void start() {
    inputCurrentIndex.add(zero);
  }

  @override
  void dispose() {
    _currentIndexController.close();
    super.dispose();
  }

  @override
  Sink get inputCurrentIndex => _currentIndexController.sink;

  @override
  Stream<int> get outputCurrentIndex => _currentIndexController.stream;

  void setIndex(int value) {
    inputCurrentIndex.add(value);
  }

  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage()
  ];

  final List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];
}

abstract class MainViewModelInputs {
  Sink get inputCurrentIndex;
}

abstract class MainViewModelOutputs {
  Stream<int> get outputCurrentIndex;
}