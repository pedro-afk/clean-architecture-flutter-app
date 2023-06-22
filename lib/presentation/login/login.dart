import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewmodel = LoginViewModel(null); // TODO: pass gere login use case

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _viewmodel.start();
    _usernameController.addListener(() =>
        _viewmodel.setUsername(_usernameController.text));
    _passwordController.addListener(() =>
        _viewmodel.setUsername(_passwordController.text));
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
                SvgPicture.asset(ImageAssets.loginIc),
                const SizedBox(height: AppSize.s28),
                StreamBuilder<bool>(
                  stream: _viewmodel.outputIsUsernameValid,
                  builder: (context, snapshot) => TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: AppStrings.username,
                      labelText: AppStrings.username,
                      errorText: (snapshot.data ?? true) ? null : AppStrings.usernameError,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                StreamBuilder<bool>(
                  stream: _viewmodel.outputIsPasswordValid,
                  builder: (context, snapshot) => TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppStrings.password,
                      labelText: AppStrings.password,
                      errorText: (snapshot.data ?? true) ? null : AppStrings.passwordError,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                StreamBuilder(
                  builder: (context, snapshot) => ElevatedButton(
                    onPressed: () {},
                    child: const Text(AppStrings.login),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(AppStrings.forgetPassword),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(AppStrings.registerText),
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
