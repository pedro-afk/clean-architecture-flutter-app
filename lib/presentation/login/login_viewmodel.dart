import 'dart:async';

import 'package:complete_advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final _usernameStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();

  var loginObject = LoginObject("", "");

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  login() {
    throw UnimplementedError();
  }

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map(_validate);

  @override
  Stream<bool> get outputIsUsernameValid =>
      _usernameStreamController.stream.map(_validate);

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    // data class operation same as kotlin
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
    // data class operation same as kotlin
  }

  bool _validate(String value) {
    return value.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  setUsername(String username);

  setPassword(String password);

  login();

  Sink get inputUsername;

  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;

  Stream<bool> get outputIsPasswordValid;
}
