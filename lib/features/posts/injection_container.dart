
import 'package:get_it/get_it.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/authentication_repository_impl.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/authentication_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/get_authenticated_User.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/my_posts_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/repositories_impl/my_posts__repo_impl.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/my_posts_repository.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_my_posts_uc.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';



Future<void> init({required GetIt sl}) async
{

 

//"my posts " feature dependencies
sl.registerFactory(() => LoadMyPostsCubit(loadMyPostsUseCase: sl()));
sl.registerLazySingleton(() => LoadMyPosts(repository: sl()));
sl.registerLazySingleton<MyPostsRepository>(() => MyPostsRepositoryImpl(tokenRepo: sl(), remoteDataSource: sl()));
sl.registerLazySingleton(() => MyPostsRemoteDataSource(apiservice: sl<HttpApiService>()));
}