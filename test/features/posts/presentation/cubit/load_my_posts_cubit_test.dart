import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_my_posts_uc.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_posts.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';

class MockLoadMyPostsUseCase extends Mock implements LoadMyPosts {}
class MockLoadPostsUseCase extends Mock implements LoadPosts{}
void main() {
  List<Post> tposts = [
    Post(
        id: '1',
        description: "test description",
        title: 'test post 1',
        date: '23-05-2024',
        proposalCount: 5,
        hiredCount: 0,
        duration: 'less than one month',
        amount: 300,
        subjects: ["math", "physics"],
        postedBy: 'hafid test',
        durationId: '2',
        postedById: '1'),
    Post(
        id: '2',
        description: "test description 2",
        title: 'test post 1',
        date: '23-05-2024',
        proposalCount: 5,
        hiredCount: 0,
        duration: 'less than one month',
        amount: 300,
        subjects: ["math", "physics"],
        postedBy: 'hafid test',
        durationId: '2',
        postedById: '2')
  ];
  MockLoadMyPostsUseCase loadMyPostsUC = MockLoadMyPostsUseCase();
  MockLoadPostsUseCase loadAllPostsUC = MockLoadPostsUseCase();
  blocTest(
      'should emit [loadMyPostsloading, loadMyPostsSuccess] when usecase respond with list of posts',
      setUp: () {
        when(() => loadMyPostsUC.getMyPosts())
            .thenAnswer((_) async => Right(tposts));
      },
      build: () => LoadPostsCubit(loadMyPostsUseCase: loadMyPostsUC,loadAllPostsUseCase: loadAllPostsUC),
      act: (cubit) => cubit.LoadMyPostsEvent(),
      expect: () => <LoadPostsState>[
            LoadPostsLoading(),
            LoadPostsSuccess(posts: tposts)
          ]);
   blocTest(
      'should emit [loadMyPostsloading, loadMyPostsError] when usecase respond with list cgccccccc of posts',
      setUp: () {
        when(() => loadMyPostsUC.getMyPosts())
            .thenAnswer((_) async =>Left(ServerFailure()));
      },
      build: () => LoadPostsCubit(loadMyPostsUseCase: loadMyPostsUC,loadAllPostsUseCase: loadAllPostsUC),
      act: (cubit) => cubit.LoadMyPostsEvent(),
      expect: () => <LoadPostsState>[
            LoadPostsLoading(),
            LoadPostsError(errorMessage: LoadPostsCubit.failureToErrorMsg(ServerFailure()))
          ]);
}
