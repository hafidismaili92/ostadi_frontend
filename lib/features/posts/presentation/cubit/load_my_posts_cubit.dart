import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_my_posts_uc.dart';


part 'load_my_posts_state.dart';

class LoadMyPostsCubit extends Cubit<LoadMyPostsState> {
  
  final LoadMyPosts loadMyPostsUseCase;
  LoadMyPostsCubit({required this.loadMyPostsUseCase}) : super(LoadMyPostsInitial());

  void LoadMyPostsEvent() async
  {
    emit(LoadMyPostsLoading());
    final result = await loadMyPostsUseCase.getMyPosts();
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
      return 'unkwnow Error When loading levels';
      default:
      return 'unkwnow Error When loading levels';
    }
  }
}
