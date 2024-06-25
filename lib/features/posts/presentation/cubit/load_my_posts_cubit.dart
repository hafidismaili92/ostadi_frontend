import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_my_posts_uc.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_posts.dart';


part 'load_my_posts_state.dart';

class LoadPostsCubit extends Cubit<LoadPostsState> {
  
  final LoadMyPosts loadMyPostsUseCase;
  final LoadPosts loadAllPostsUseCase;
  LoadPostsCubit({required this.loadMyPostsUseCase,required this.loadAllPostsUseCase}) : super(LoadPostsInitial());

  void LoadMyPostsEvent() async
  {
    
    emit(LoadPostsLoading());
    final result = await loadMyPostsUseCase.getMyPosts();
    result.fold((failure) => emit(LoadPostsError(errorMessage: failureToErrorMsg(failure))), (posts) => emit(LoadPostsSuccess(posts: posts)));
  }

  void LoadAllPostsEvent() async
  {
    emit(LoadPostsLoading());
    final result = await loadAllPostsUseCase.getPosts();
    result.fold((failure) => emit(LoadPostsError(errorMessage: failureToErrorMsg(failure))), (posts) => emit(LoadPostsSuccess(posts: posts)));
  }

  static String failureToErrorMsg(Failure failure) {
    switch(failure.runtimeType)
    {
      case ServerFailure:
      return 'error from Server';
       case ConnectionFailure:
      return 'No internet connection';
      
      case UnknownFailure:
      return 'unkwnow Error When loading Posts';
      default:
      return 'unkwnow Error When loading Posts';
    }
  }
}
