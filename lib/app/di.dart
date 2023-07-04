import 'package:complete_advanced_flutter/app/app_prefs.dart';
import 'package:complete_advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/network/app_api.dart';
import 'package:complete_advanced_flutter/data/network/dio_factory.dart';
import 'package:complete_advanced_flutter/data/network/network_info.dart';
import 'package:complete_advanced_flutter/data/repository/repository_impl.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared preferences
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));

  // network info
  getIt.registerLazySingleton<NetworkInfoImpl>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  getIt.registerLazySingleton<DioFactory>(() => DioFactory(getIt()));

  // app service client
  final dio = await getIt<DioFactory>().getDio();
  getIt.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  getIt.registerLazySingleton<RemoteDataSourceImplementer>(
      () => RemoteDataSourceImplementer(getIt()));

  // repository
  getIt.registerLazySingleton<Repository>(
      () => RepositoryImpl(getIt(), getIt()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    getIt.registerFactory<LoginUseCase>(() => LoginUseCase(getIt()));
    getIt.registerFactory<LoginViewModel>(() => LoginViewModel(getIt()));
  }
}