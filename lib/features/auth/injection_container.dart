
import 'package:get_it/get_it.dart';
import 'package:ostadi_frontend/features/auth/data/models/register_user_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_prof_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_student_use_case.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/register_user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async
{
  /*sl.registerFactory(() => RegisterUserCubit(registerProfUC: sl(), registerStudentUC: sl()));
  sl.registerLazySingleton(() =>  RegisterProfUseCase(repository: sl()));
  sl.registerLazySingleton(() =>  RegisterStudentUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUserRepo>(() => RegisterUserRepoImpl());*/
}