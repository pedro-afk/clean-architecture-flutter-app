import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewmodel = getIt<LoginViewModel>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _viewmodel.start();
    _usernameController
        .addListener(() => _viewmodel.setUsername(_usernameController.text));
    _passwordController
        .addListener(() => _viewmodel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p100,
            left: AppPadding.p28,
            right: AppPadding.p28,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(ImageAssets.splashLogo),
                const SizedBox(height: AppSize.s28),
                StreamBuilder<bool>(
                  stream: _viewmodel.outputIsUsernameValid,
                  builder: (context, snapshot) => CustomTextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: AppStrings.username,
                    labelText: AppStrings.username,
                    errorText: (snapshot.data ?? true)
                        ? null
                        : AppStrings.usernameError,
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                StreamBuilder<bool>(
                  stream: _viewmodel.outputIsPasswordValid,
                  builder: (context, snapshot) => CustomTextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    hintText: AppStrings.password,
                    labelText: AppStrings.password,
                    errorText: (snapshot.data ?? true)
                        ? null
                        : AppStrings.passwordError,
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                StreamBuilder<bool>(
                  stream: _viewmodel.outputIsAllInputsValid,
                  builder: (context, snapshot) => SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () => _viewmodel.login()
                          : null,
                      child: Text(
                        AppStrings.login,
                        style: getMediumStyle(color: ColorManager.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, Routes.forgotPasswordRoute),
                      child: Text(
                        AppStrings.forgetPassword,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.registerRoute),
                      child: Text(
                        AppStrings.registerText,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
