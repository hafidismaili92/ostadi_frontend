import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/add_job_post_uc.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';

part 'new_post_state.dart';

class NewPostCubit extends Cubit<NewPostState> {
  AddJobPostUseCase addJobUC;

  NewPostCubit({required this.addJobUC}) : super(NewPostInitial());

  void submitNewPost(PostParams postParams) async 
  {
    emit(AddingNewPostLoading());
    final result = await addJobUC.execute(postParams);
    result.fold((failure) => emit(AddingNewPostError(errorMessage: failureToErrorMsg(failure))), (post) => emit(AddingNewPostSuccess(post: post)));
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

  void resetState() {
    emit(NewPostInitial());
  }
  
}
