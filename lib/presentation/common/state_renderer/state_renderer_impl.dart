import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

class AlertState extends FlowState {
  String message;

  AlertState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupAlertState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget content,
    void Function() retryAction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          showPopup(context, getStateRendererType(), getMessage(), retryAction);
          return content;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            onRetry: retryAction,
          );
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          showPopup(
            context,
            getStateRendererType(),
            getMessage(),
            () => Navigator.pop(context),
          );
          return content;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            onRetry: retryAction,
          );
        }
      case ContentState:
        dismissDialog(context);
        return content;
      case EmptyState:
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
          onRetry: retryAction,
        );
      case AlertState:
        if (getStateRendererType() == StateRendererType.popupAlertState) {
          showPopup(
            context,
            getStateRendererType(),
            getMessage(),
            () => Navigator.pop(context),
          );
        }
        return content;
      default:
        return content;
    }
  }

  void dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  bool _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  void showPopup(
    BuildContext context,
    StateRendererType stateRendererType,
    String message,
    void Function() onRetry,
  ) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          context: context,
          builder: (context) {
            return StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              onRetry: onRetry,
            );
          },
        );
      },
    );
  }
}
