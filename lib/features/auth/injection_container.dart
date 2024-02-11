
import 'package:get_it/get_it.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/load_subjects_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/register_user_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_subjects_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_subjects_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_prof_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_student_use_case.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/load_subjects_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/register_user_cubit.dart';



Future<void> init({required GetIt sl}) async
{

  sl.registerFactory(() => RegisterUserCubit(registerProfUC: sl(), registerStudentUC: sl()));
  sl.registerLazySingleton(() =>  RegisterProfUseCase(repository: sl()));
  sl.registerLazySingleton(() =>  RegisterStudentUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUserRepo>(() => RegisterUserRepoImpl(remoteDataSource: sl()));

  //load subjects dependencies (note connectionInfo and HttpApiService already registred in global)
  sl.registerFactory(() => LoadSubjectsCubit(loadSUbjectsUC: sl()));
  sl.registerLazySingleton(() =>  LoadSubjectsUseCase(repository: sl()));
  sl.registerLazySingleton<LoadSubjectsRepository>(() => LoadSubjectsRepoImpl(remoteDataSource: sl(),connectionInfo: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImplementation(apiservice: sl<HttpApiService>()) );
  
}