import 'dart:developer';

import 'package:complete_advanced_flutter/app/app.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  void updateAppState() {
    MyApp.instance.appState = 10;
  }

  void getAppState() {
    log(MyApp.instance.appState.toString()); // 10
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
