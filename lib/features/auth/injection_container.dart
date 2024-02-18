
import 'package:get_it/get_it.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/load_levels_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/load_subjects_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/login_repository_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/register_user_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/authentication_repository_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_levels_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_subjects_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/login_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/authentication_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/get_authenticated_User.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_levels_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_subjects_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/login_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_prof_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_student_use_case.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/load_levels_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/load_subjects_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/login_cubit_dart_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/register_user_cubit.dart';



Future<void> init({required GetIt sl}) async
{

 

  //"load subjects" feature dependencies (note connectionInfo and HttpApiService already registred in global)
  sl.registerFactory(() => LoadSubjectsCubit(loadSUbjectsUC: sl()));
  sl.registerLazySingleton(() =>  LoadSubjectsUseCase(repository: sl()));
  sl.registerLazySingleton<LoadSubjectsRepository>(() => LoadSubjectsRepoImpl(remoteDataSource: sl(),connectionInfo: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImplementation(apiservice: sl<HttpApiService>()) );

  //"load levels" feature  dependencies from server (note remote data sources already registred see upon)
  sl.registerFactory(() => LoadLevelsCubit(loadLevelsUC: sl()));
  sl.registerLazySingleton(() =>  LoadLevelsUseCase(repository: sl()));
  sl.registerLazySingleton<LoadLevelsRepository>(() => LoadLevelsRepoImpl(remoteDataSource: sl(),connectionInfo: sl()));
  
  //"register user" feature dependencies 

  sl.registerFactory(() => RegisterUserCubit(registerProfUC: sl(), registerStudentUC: sl()));
  sl.registerLazySingleton(() =>  RegisterProfUseCase(repository: sl()));
  sl.registerLazySingleton(() =>  RegisterStudentUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUserRepo>(() => RegisterUserRepoImpl(remoteDataSource: sl()));

  //"token repos" dependencies

  sl.registerLazySingleton<TokenRepository>(() => TokenRepository(secureStorage: sl()));

  //"login feature" dependencies
sl.registerFactory(() => LoginCubitDartCubit(loginUC: sl()));
sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(connectionInfo: sl(),remoteDataSource: sl(), tokenRepository: sl()));

//"authentication" feature dependicies
sl.registerFactory(() => AuthenticationCubit(getAuthenticatedUserUC: sl()));
sl.registerLazySingleton(() => GetAuthenticatedUserUC(authRepository: sl()));
sl.registerLazySingleton<AuthenticationRepository>(()=>AuthenticationRepositoryImpl(remoteDS: sl(), tokenRepo: sl()));

}