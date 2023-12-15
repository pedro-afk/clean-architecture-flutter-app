import 'dart:async';
import 'dart:io';

import 'package:complete_advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final _usernameStreamController = StreamController<String>.broadcast();
  final _mobileNumberStreamController = StreamController<String>.broadcast();
  final _emailStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _profilePictureStreamController = StreamController<File>.broadcast();
  final _isAllInputsValidStreamController = StreamController<bool?>.broadcast();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _usernameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  Future<void> register() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
          registerObject.countryMobileCode,
          registerObject.username,
          registerObject.email,
          registerObject.password,
          registerObject.mobileNumber,
          registerObject.profilePicture),
    )).fold((failure) {
      inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) {
      inputState.add(ContentState());
    });
  }

  @override
  Sink get inputEmailStreamController => _emailStreamController.sink;

  @override
  Sink get inputMobileNumberStreamController =>
      _mobileNumberStreamController.sink;

  @override
  Sink get inputPasswordStreamController => _passwordStreamController.sink;

  @override
  Sink get inputProfilePictureStreamController =>
      _profilePictureStreamController.sink;

  @override
  Sink get inputUsernameStreamController => _usernameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  Stream<File> get outputIsValidProfilePicture =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsValidUsername =>
      _usernameStreamController.stream.map(_isValidUsername);

  @override
  Stream<String?> get outputErrorUsername => outputIsValidUsername
      .map((isValidUsername) => isValidUsername ? null : "Invalid username");

  @override
  Stream<bool> get outputIsValidEmail =>
      _emailStreamController.stream.map(_isValidEmail);

  @override
  Stream<String?> get outputErrorEmail => outputIsValidEmail
      .map((isValidEmail) => isValidEmail ? null : "Invalid e-mail");

  @override
  Stream<bool> get outputIsValidPassword =>
      _passwordStreamController.stream.map(_isValidPassword);

  @override
  Stream<String?> get outputErrorPassword => outputIsValidPassword
      .map((isValidPassword) => isValidPassword ? null : "Invalid password");

  @override
  Stream<bool> get outputIsValidMobileNumber =>
      _mobileNumberStreamController.stream.map(_isValidMobileNumber);

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsValidMobileNumber.map((isValidMobileNumber) =>
          isValidMobileNumber ? null : "Invalid mobile number");

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());

  @override
  void setEmail(String email) {
    if (!_isValidEmail(email)) {
      registerObject = registerObject.copyWith(email: "");
    } else {
      inputEmailStreamController.add(email);
      registerObject = registerObject.copyWith(email: email);
    }
    _validate();
  }

  @override
  void setMobileNumber(String mobileNumber) {
    if (!_isValidMobileNumber(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: "");
    } else {
      inputMobileNumberStreamController.add(mobileNumber);
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    }
    _validate();
  }

  @override
  void setPassword(String password) {
    if (!_isValidPassword(password)) {
      registerObject = registerObject.copyWith(password: "");
    } else {
      inputPasswordStreamController.add(password);
      registerObject = registerObject.copyWith(password: password);
    }
    _validate();
  }

  @override
  void setProfilePicture(File picture) {
    if (picture.path.isEmpty) {
      registerObject = registerObject.copyWith(profilePicture: "");
    } else {
      inputProfilePictureStreamController.add(picture);
      registerObject = registerObject.copyWith(profilePicture: picture.path);
    }
    _validate();
  }

  @override
  void setUsername(String username) {
    if (!_isValidUsername(username)) {
      registerObject = registerObject.copyWith(username: "");
    } else {
      inputUsernameStreamController.add(username);
      registerObject = registerObject.copyWith(username: username);
    }
    _validate();
  }

  @override
  void setCountryCode(String countryCode) {
    if (countryCode.isEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    }
    _validate();
  }

  bool _isValidEmail(String email) {
    return email.isNotEmpty;
  }

  bool _isValidMobileNumber(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  bool _isValidUsername(String username) {
    return username.length >= 8;
  }

  bool _validateAllInputs() {
    return [
      registerObject.username,
      registerObject.email,
      registerObject.password,
      registerObject.mobileNumber,
      registerObject.countryMobileCode,
      registerObject.profilePicture,
    ].isNotEmpty;
  }

  void _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  void setUsername(String username);

  void setCountryCode(String countryCode);

  void setMobileNumber(String mobileNumber);

  void setEmail(String email);

  void setPassword(String password);

  void setProfilePicture(File picture);

  Future<void> register();

  Sink get inputUsernameStreamController;

  Sink get inputMobileNumberStreamController;

  Sink get inputEmailStreamController;

  Sink get inputPasswordStreamController;

  Sink get inputProfilePictureStreamController;

  Sink get inputAllInputsValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsValidUsername;

  Stream<String?> get outputErrorUsername;

  Stream<bool> get outputIsValidMobileNumber;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsValidEmail;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsValidPassword;

  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsValidProfilePicture;

  Stream<bool> get outputIsAllInputsValid;
}
