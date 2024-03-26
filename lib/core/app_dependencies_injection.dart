import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ostadi_frontend/core/platform/connectionInfo.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';

import 'package:ostadi_frontend/features/auth/injection_container.dart' as authDependencies;
import 'package:ostadi_frontend/features/posts/injection_container.dart' as myPostsDependencies;
final GetIt sl = GetIt.instance;

Future<void> init() async {
  
  
  sl.registerSingleton(HttpApiService());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerSingleton<Connectioninfo>(ConnectioninfoImpl(connectionChecker: sl()));
  sl.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  
  //"token repos" dependencies

  sl.registerLazySingleton<TokenRepository>(() => TokenRepository(secureStorage: sl()));
  
  //features dependencies injections goes here
  await authDependencies.init(sl:sl);
  await myPostsDependencies.init(sl: sl);
}