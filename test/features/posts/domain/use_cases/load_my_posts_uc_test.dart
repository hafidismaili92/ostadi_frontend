

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/posts_repository.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_my_posts_uc.dart';
import 'package:test/test.dart';

class MockRepository extends Mock implements PostsRepository{}
void main() {
  List<Post> tposts = [Post(id: '1',description: "test description", title: 'test post 1', date: '23-05-2024', proposalCount: 5, hiredCount: 0, duration: 'less than one month',durationId: '2', amount: 300, subjects: ["math","physics"], postedBy: 'hafid test', postedById: '1')];
  late LoadMyPosts tloadPostsUC;
  MockRepository repository = MockRepository();
  setUp((){
    tloadPostsUC = LoadMyPosts(repository: repository);
  });
  test('load my posts list success (return list<Post>)',() async {
    //arrange
    when(()=>repository.loadMyPosts()).thenAnswer((_) async => Right(tposts) );
    //act
    final result = await tloadPostsUC.getMyPosts();
    //assert
    expect(result, Right(tposts));
    verify(()=>repository.loadMyPosts());
  });

  test('load my posts list return failure when repo return failure',() async {
    //arrange
    when(()=>repository.loadMyPosts()).thenAnswer((_) async => Left(ServerFailure()) );
    //act
    final result = await tloadPostsUC.getMyPosts();
    //assert
    expect(result, isA<Left<Failure,List<Post>>>());
    verify(()=>repository.loadMyPosts());
  });
}