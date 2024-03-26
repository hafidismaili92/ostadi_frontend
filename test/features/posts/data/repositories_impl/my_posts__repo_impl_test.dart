import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/my_posts_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/models/post_model.dart';
import 'package:ostadi_frontend/features/posts/data/repositories_impl/my_posts__repo_impl.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';

class MockRemoteDS extends Mock implements MyPostsRemoteDataSource{}
class MockTokenRepo extends Mock implements TokenRepository{}

void main() {
  List<PostModel> tposts = [PostModel(id: '1', title: 'test post 1',description: "test description",date: '23-05-2024', proposalCount: 5, hiredCount: 0, duration: 'less than one month', amount: 300, subjects: ["math","physics"], postedBy: 'hafid test', postedById: '1')];
  MockRemoteDS mockDS = MockRemoteDS();
  MockTokenRepo tokenRepo = MockTokenRepo();
  late MyPostsRepositoryImpl testRepo;

  setUp((){
    testRepo = MyPostsRepositoryImpl(remoteDataSource: mockDS,tokenRepo: tokenRepo);
  });
  test('return a list of posts when datasource respond a list of post models',() async {
    //arrange
    when(()=>mockDS.loadMyPosts(any())).thenAnswer((_) async => tposts);
    when(()=>tokenRepo.readToken()).thenAnswer((_) async => 'testtoken');
    //test
    final result = await testRepo.loadMyPosts();
    //assert
    expect(result, Right(tposts));

  });
  test('return a Failure when datasource throw an exception',() async {
    //arrange
    when(()=>mockDS.loadMyPosts(any())).thenThrow(ServerException());
    when(()=>tokenRepo.readToken()).thenAnswer((_) async => 'testtoken');
    //test
    final result = await testRepo.loadMyPosts();
    //assert
    expect(result, Left(ServerFailure()));

  });
}