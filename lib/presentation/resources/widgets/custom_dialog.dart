import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? content;
  final MainAxisAlignment? actionsAlignment;

  const CustomDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.actionsAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      titlePadding: const EdgeInsets.all(AppPadding.p8),
      actionsPadding: const EdgeInsets.all(AppPadding.p8),
      title: title != null ? Text(title ?? empty) : const SizedBox(),
      actions: actions,
      actionsAlignment: actionsAlignment,
      content: content,
    );
  }
}
