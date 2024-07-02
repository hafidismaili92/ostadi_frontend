
import 'package:get_it/get_it.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/authentication_repository_impl.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/authentication_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/get_authenticated_User.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/duration_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/my_posts_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/proposals_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/repositories_impl/duration_repo_impl.dart';
import 'package:ostadi_frontend/features/posts/data/repositories_impl/posts__repo_impl.dart';
import 'package:ostadi_frontend/features/posts/data/repositories_impl/proposal_repo_impl.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/duration_repository.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/posts_repository.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/proposal_repository.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/add_job_post_uc.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_durations_uc.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_my_posts_uc.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_posts.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/submit_proposal_usecase.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_duration_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/new_post_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/submit_proposal_cubit.dart';



Future<void> init({required GetIt sl}) async
{

 //load durations list dependencies
sl.registerFactory(() => LoadDurationCubit(loadDurationUC: sl()));
sl.registerLazySingleton(() => LoadDurations(repository: sl()));
sl.registerLazySingleton<DurationRepository>(() => DurationRepositoryImpl(datasource: sl()));
sl.registerLazySingleton(() => DurationRemoteDataSource(apiservice: sl<HttpApiService>()));
//"posts " feature dependencies
sl.registerFactory(() => LoadPostsCubit(loadMyPostsUseCase: sl(),loadAllPostsUseCase: sl()));
sl.registerLazySingleton(() => LoadMyPosts(repository: sl()));
sl.registerLazySingleton(() => LoadPosts(repository: sl()));
sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(tokenRepo: sl(), remoteDataSource: sl()));
sl.registerLazySingleton(() => PostsRemoteDataSource(apiservice: sl<HttpApiService>()));
//submit new post by student
sl.registerFactory(() =>NewPostCubit(addJobUC: sl()));
sl.registerLazySingleton(() => AddJobPostUseCase(repository: sl()));
//note that for reposetory and remote datasource we did already registred them for above post load 

//submit proposal dependencies
sl.registerFactory(() => SubmitProposalCubit(submitUseCase: sl()));
sl.registerLazySingleton(() => SubmitProposalUseCase(repositoy: sl()));
sl.registerLazySingleton<ProposalRepositoy>(() => ProposalRepositoryImpl(tokenRepo: sl(), remoteDS: sl()));
sl.registerLazySingleton(() => ProposalRemoteDataSource(apiservice: sl<HttpApiService>()));
}