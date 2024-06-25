import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/add_job_post_uc.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/new_post_cubit.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';

class MockAddPostUC extends Mock implements AddJobPostUseCase{}
void main() {
  final MockAddPostUC mockaddpostUC = MockAddPostUC();
  final postTest = Post(id: '1',description: "Eu fugiat veniam reprehenderit do incididunt officia.", title: 'test post 1', date: '23-05-2024', proposalCount: 5, hiredCount: 0, duration: 'less than one month',durationId: '2', amount: 200.5, subjects: ["math","physics"], postedBy: 'hafid test', postedById: '1');
  final postParams = PostParams(title: 'test post 1',description: 'Eu fugiat veniam reprehenderit do incididunt officia.',amount: 200.5,duration: '2');
  blocTest('should emit [AddingNewPostLoading,AddingNewPostSuccess] when usecase called and it respond with a Right(Post)',setUp: (){
    when(()=>mockaddpostUC.execute(postParams)).thenAnswer((_) async => Right(postTest));
  },build: ()=>NewPostCubit(addJobUC: mockaddpostUC),act: (cubit) => cubit.submitNewPost(postParams),
      expect: () => <NewPostState>[
            AddingNewPostLoading(),
            AddingNewPostSuccess(post: postTest)
          ]);
  blocTest('should emit [AddingNewPostLoading,AddingNewPostError] when usecase called and it respond with a Left(Failure)',setUp: (){
    when(()=>mockaddpostUC.execute(postParams)).thenAnswer((_) async => Left(ServerFailure()));
  },build: ()=>NewPostCubit(addJobUC: mockaddpostUC),act: (cubit) => cubit.submitNewPost(postParams),
      expect: () => <NewPostState>[
            AddingNewPostLoading(),
            AddingNewPostError(errorMessage: NewPostCubit.failureToErrorMsg(ServerFailure()))
          ]);
}