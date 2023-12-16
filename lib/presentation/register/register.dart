import 'dart:io';

import 'package:complete_advanced_flutter/app/app_prefs.dart';
import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/data/service/image_picker.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:complete_advanced_flutter/presentation/register/register_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/widgets/custom_text_form_field.dart';
import 'package:complete_advanced_flutter/presentation/resources/widgets/profile_picture_preview.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../resources/assets_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _viewModel = instance<RegisterViewModel>();
  final _appPreferences = instance<AppPreferences>();
  final _serviceImagePicker = instance<ServiceImagePicker>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlMobileNumber = TextEditingController();
  final TextEditingController _ctrlCountryCodeNumber = TextEditingController();

  void _bind() {
    _viewModel.start();
    _ctrlUsername.addListener(() {
      _viewModel.setUsername(_ctrlUsername.text);
    });
    _ctrlEmail.addListener(() {
      _viewModel.setEmail(_ctrlEmail.text);
    });
    _ctrlPassword.addListener(() {
      _viewModel.setPassword(_ctrlPassword.text);
    });
    _ctrlMobileNumber.addListener(() {
      _viewModel.setMobileNumber(_ctrlMobileNumber.text);
    });
    _ctrlCountryCodeNumber.addListener(() {
      _viewModel.setCountryCode(_ctrlCountryCodeNumber.text);
    });
    _ctrlUsername.addListener(() {
      _viewModel.setUsername(_ctrlUsername.text);
    });

    _viewModel.isUserRegisteredInSuccessfullyStreamController.stream.listen((isRegistered) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s0,
        shadowColor: ColorManager.transparent,
        backgroundColor: ColorManager.transparent,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _registerBody(),
                () {
                  _viewModel.register();
                },
              ) ??
              _registerBody();
        },
      ),
    );
  }

  Widget _registerBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Image.asset(ImageAssets.splashLogo),
            const SizedBox(height: AppSize.s16),
            StreamBuilder<String?>(
              stream: _viewModel.outputErrorUsername,
              builder: (context, snapshot) => CustomTextFormField(
                  controller: _ctrlUsername,
                  hintText: AppStrings.username,
                  labelText: AppStrings.username,
                  errorText: snapshot.data),
            ),
            const SizedBox(height: AppSize.s16),
            Row(
              children: [
                Expanded(
                  flex: AppSize.si1,
                  child: CountryCodePicker(
                    showCountryOnly: true,
                    initialSelection: "+55",
                    showOnlyCountryWhenClosed: true,
                    onInit: (countryCode) =>
                        _viewModel.setCountryCode(countryCode?.dialCode ?? empty),
                    onChanged: (countryCode) =>
                        _viewModel.setCountryCode(countryCode.dialCode ?? empty),
                    hideMainText: true,
                  ),
                ),
                Expanded(
                  flex: AppSize.si3,
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorMobileNumber,
                    builder: (context, snapshot) => CustomTextFormField(
                        controller: _ctrlMobileNumber,
                        hintText: AppStrings.mobileNumber,
                        labelText: AppStrings.mobileNumber,
                        errorText: snapshot.data),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s16),
            StreamBuilder<String?>(
              stream: _viewModel.outputErrorEmail,
              builder: (context, snapshot) => CustomTextFormField(
                  controller: _ctrlEmail,
                  hintText: AppStrings.email,
                  labelText: AppStrings.email,
                  errorText: snapshot.data),
            ),
            const SizedBox(height: AppSize.s16),
            StreamBuilder<String?>(
              stream: _viewModel.outputErrorPassword,
              builder: (context, snapshot) => CustomTextFormField(
                  controller: _ctrlPassword,
                  hintText: AppStrings.password,
                  obscureText: true,
                  labelText: AppStrings.password,
                  errorText: snapshot.data),
            ),
            const SizedBox(height: AppSize.s16),
            StreamBuilder<File?>(
              stream: _viewModel.outputIsValidProfilePicture,
              builder: (context, snapshot) {
                return ProfilePicturePreview(
                  file: snapshot.data,
                  onTap: _showPicker,
                );
              }
            ),
            const SizedBox(height: AppSize.s16),
            StreamBuilder<bool>(
              stream: _viewModel.outputIsAllInputsValid,
              builder: (context, snapshot) => SizedBox(
                width: double.infinity,
                height: AppSize.s40,
                child: ElevatedButton(
                  onPressed: (snapshot.data ?? false)
                      ? () => _viewModel.register()
                      : null,
                  child: Text(
                    AppStrings.register,
                    style: getMediumStyle(color: ColorManager.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppStrings.alreadyRegistered,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPicker() {
    showModalBottomSheet(context: context, builder: (context) {
      return Wrap(
        children: [
          ListTile(
            trailing: const Icon(Icons.navigate_next),
            leading: const Icon(Icons.add_photo_alternate_outlined),
            title: const Text(AppStrings.photoGallery),
            onTap: _openGallery,
          ),
          const Divider(),
          ListTile(
            trailing: const Icon(Icons.navigate_next),
            leading: const Icon(Icons.add_a_photo_outlined),
            title: const Text(AppStrings.takePicture),
            onTap: _openCamera,
          ),
        ],
      );
    });
  }

  Future<void> _openGallery() async {
    File? image = await _serviceImagePicker.pickImageFromGallery;
    if (image != null) {
      _viewModel.setProfilePicture(image);
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> _openCamera() async {
    File? image = await _serviceImagePicker.pickImageFromCamera;
    if (image != null) {
      _viewModel.setProfilePicture(image);
      if (mounted) Navigator.pop(context);
    }
  }
}
