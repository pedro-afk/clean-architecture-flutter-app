import 'package:complete_advanced_flutter/app/app_prefs.dart';
import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _usernameController
        .addListener(() => _viewModel.setUsername(_usernameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSuccessLogin) {
      _appPreferences.setIsUserLoggedIn();
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
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
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _loginBody(),
                () {
                  _viewModel.login();
                },
              ) ??
              _loginBody();
        },
      ),
    );
  }

  // TODO: refactor
  Widget _loginBody() {
    return SingleChildScrollView(
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
                stream: _viewModel.outputIsUsernameValid,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppStrings.username,
                  labelText: AppStrings.username,
                  errorText:
                      (snapshot.data ?? true) ? null : AppStrings.usernameError,
                ),
              ),
              const SizedBox(height: AppSize.s28),
              StreamBuilder<bool>(
                stream: _viewModel.outputIsPasswordValid,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hintText: AppStrings.password,
                  labelText: AppStrings.password,
                  errorText:
                      (snapshot.data ?? true) ? null : AppStrings.passwordError,
                ),
              ),
              const SizedBox(height: AppSize.s28),
              StreamBuilder<bool>(
                stream: _viewModel.outputIsAllInputsValid,
                builder: (context, snapshot) => SizedBox(
                  width: double.infinity,
                  height: AppSize.s40,
                  child: ElevatedButton(
                    onPressed: (snapshot.data ?? false)
                        ? () => _viewModel.login()
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
    );
  }
}
