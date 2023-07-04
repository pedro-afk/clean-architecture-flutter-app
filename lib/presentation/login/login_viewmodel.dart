import 'dart:async';

import 'package:complete_advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final _usernameStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _isAllInputsValidStreamController = StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  final LoginUseCase? _loginUseCase; // todo remove ?

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Future<void> login() async {
  /*  (await _loginUseCase!.execute(
      LoginUseCaseInput(loginObject.username, loginObject.password),
    )).fold((failure) => {
      // left -> failure
      log(failure.message)
    }, (data) => {
      // right -> success
      log(data.customer?.name ?? "")
    });*/
  }

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map(_isValidPassword);

  @override
  Stream<bool> get outputIsUsernameValid =>
      _usernameStreamController.stream.map(_isValidUsername);

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    // data class operation same as kotlin
    _resetInputIsAllInput();
  }

  @override
  void setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
    // data class operation same as kotlin
    _resetInputIsAllInput();
  }

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  bool _isValidPassword(String password) {
    return password.isNotEmpty;
  }

  bool _isValidUsername(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isValidPassword(loginObject.password) && _isValidUsername(loginObject.username);
  }

  void _resetInputIsAllInput() {
    inputIsAllInputValid.add(null);
  }
}

abstract class LoginViewModelInputs {
  void setUsername(String username);

  void setPassword(String password);

  Future<void> login();

  Sink get inputUsername;

  Sink get inputPassword;
  
  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;

  Stream<bool> get outputIsPasswordValid;
  
  Stream<bool> get outputIsAllInputsValid;
}
