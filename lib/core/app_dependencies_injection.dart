import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ostadi_frontend/core/platform/connectionInfo.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/injection_container.dart' as authDependencies;
final GetIt sl = GetIt.instance;

Future<void> init() async {
  
  
  sl.registerSingleton(HttpApiService());
  // Other global dependencies

  //external global dependencies
  
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerSingleton<Connectioninfo>(ConnectioninfoImpl(connectionChecker: sl()));
  //features dependencies injections goes here
  await authDependencies.init(sl:sl);

}