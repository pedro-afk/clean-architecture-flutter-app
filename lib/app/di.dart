import 'package:complete_advanced_flutter/app/app_prefs.dart';
import 'package:complete_advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/network/app_api.dart';
import 'package:complete_advanced_flutter/data/network/dio_factory.dart';
import 'package:complete_advanced_flutter/data/network/network_info.dart';
import 'package:complete_advanced_flutter/data/repository/repository_impl.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:complete_advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:complete_advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:complete_advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/register/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared preferences
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));

  instance.registerSingleton(OnBoardingViewModel());
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
    instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
  }
}