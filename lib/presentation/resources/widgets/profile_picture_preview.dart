import 'dart:io';

import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfilePicturePreview extends StatelessWidget {
  final File? file;
  final void Function()? onTap;

  const ProfilePicturePreview({super.key, this.file, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (file != null && (file?.path ?? empty).isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: Border.all(color: ColorManager.darkGrey),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppPadding.p16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: ColorManager.darkGrey),
                ),
              ),
              child: GestureDetector(
                onTap: onTap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(file!.path,
                            style:
                                getMediumStyle(color: ColorManager.lightGrey))),
                    Icon(Icons.camera_alt_outlined,
                        color: ColorManager.lightGrey),
                  ],
                ),
              ),
            ),
            Center(
              child: Image.file(
                file!,
                fit: BoxFit.cover,
                height: AppSize.s300,
                width: double.infinity,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: AppSize.s200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: ColorManager.darkGrey),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorManager.darkGrey),
              ),
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.profilePicture.tr(),
                      style: getMediumStyle(color: ColorManager.lightGrey)),
                  Icon(Icons.camera_alt_outlined,
                      color: ColorManager.lightGrey),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppStrings.imagePreview.tr(),
                style: getMediumStyle(color: ColorManager.lightGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
