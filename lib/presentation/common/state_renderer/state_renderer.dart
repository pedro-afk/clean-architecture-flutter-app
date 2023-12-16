import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/font_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

enum StateRendererType {
  popupLoadingState,
  popupErrorState,
  popupAlertState,
  fullscreenLoadingState,
  fullscreenErrorState,
  contentScreenState,
  emptyScreenState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String? title;
  final void Function() onRetry;

  const StateRenderer({
    super.key,
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title = empty,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return const CustomDialog(
          content: SizedBox(
            height: AppSize.s50,
            child: Wrap(
              spacing: AppSize.s8,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                CircularProgressIndicator(),
                Message(message: AppStrings.loading),
              ],
            ),
          ),
        );
      case StateRendererType.popupErrorState:
        return CustomDialog(
          content: Message(message: message),
          actions: [RetryButton(title: AppStrings.ok, onRetry: onRetry)],
        );
      case StateRendererType.fullscreenLoadingState:
        return const ItemsInColumn(
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox(height: AppSize.s8),
            Center(child: Message(message: AppStrings.loading)),
          ],
        );
      case StateRendererType.fullscreenErrorState:
        return ItemsInColumn(
          children: [
            Center(child: Message(message: message)),
            Center(child: RetryButton(title: AppStrings.retryAgain, onRetry: onRetry))
          ],
        );
      case StateRendererType.emptyScreenState:
        return ItemsInColumn(children: [Message(message: message)]);
      case StateRendererType.popupAlertState:
        return CustomDialog(
          content: Message(message: message),
          actions: [RetryButton(title: AppStrings.ok, onRetry: onRetry)],
        );
      default:
        return const SizedBox();
    }
  }
}

class RetryButton extends StatelessWidget {
  final String title;
  final void Function() onRetry;

  const RetryButton({super.key, required this.title, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onRetry,
      child: Text(
        title,
        style: getMediumStyle(color: ColorManager.white),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String message;

  const Message({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: getMediumStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
    );
  }
}

class ItemsInColumn extends StatelessWidget {
  final List<Widget> children;

  const ItemsInColumn({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
