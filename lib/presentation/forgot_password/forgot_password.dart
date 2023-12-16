import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:complete_advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _viewModel = instance<ForgotPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();

  void _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
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
        backgroundColor: ColorManager.transparent,
        elevation: AppSize.s0,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _forgotPasswordBody(),
                () => _viewModel.forgotPassword(),
              ) ??
              _forgotPasswordBody();
        },
      ),
    );
  }

  Widget _forgotPasswordBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppSize.s28),
          Image.asset(ImageAssets.splashLogo),
          const SizedBox(height: AppSize.s28),
          StreamBuilder<bool>(
            stream: _viewModel.outputVerifyEmail,
            builder: (context, snapshot) => CustomTextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: AppStrings.emailHint.tr(),
              labelText: AppStrings.emailHint.tr(),
              errorText: (snapshot.data ?? true) ? null : AppStrings.invalidEmail.tr(),
            ),
          ),
          const SizedBox(height: AppSize.s28),
          StreamBuilder<bool>(
            stream: _viewModel.outputVerifyEmail,
            builder: (context, snapshot) => Wrap(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: AppSize.s40,
                  child: ElevatedButton(
                    onPressed: (snapshot.data ?? false)
                        ? () => _viewModel.forgotPassword()
                        : null,
                    child: Text(
                      AppStrings.resetPassword.tr(),
                      style: getMediumStyle(color: ColorManager.white),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: (snapshot.data ?? false)
                        ? () => _viewModel.forgotPassword()
                        : null,
                    child: Text(
                      AppStrings.resendEmail.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
