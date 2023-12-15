import 'dart:async';

import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final _emailStreamController = StreamController<String>.broadcast();
  var forgotPasswordObject = ForgotPasswordObject("");

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  @override
  void dispose() {
    _emailStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outputVerifyEmail =>
      _emailStreamController.stream.map(_isValidEmail);

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    forgotPasswordObject = forgotPasswordObject.copyWith(email: email);
  }

  @override
  Future<void> forgotPassword() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullscreenLoadingState));
    (await _forgotPasswordUseCase
            .execute(ForgotPasswordUseCaseInput(forgotPasswordObject.email)))
        .fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) {
      inputState.add(AlertState(data.support ?? empty));
    });
  }

  bool _isValidEmail(String event) => event.isNotEmpty;
}

abstract class ForgotPasswordViewModelInputs {
  Future<void> forgotPassword();

  void setEmail(String email);

  Sink get inputEmail;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputVerifyEmail;
}
