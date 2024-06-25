import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/my_posts_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/models/post_model.dart';
import 'package:ostadi_frontend/features/posts/data/repositories_impl/posts__repo_impl.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';

class MockRemoteDS extends Mock implements PostsRemoteDataSource{}
class MockTokenRepo extends Mock implements TokenRepository{}

void main() {
  List<PostModel> tposts = [PostModel(id: '1', title: 'test post 1',description: "test description",date: '23-05-2024', proposalCount: 5, hiredCount: 0, duration: 'less than one month',durationId: '2', amount: 300, subjects: ["math","physics"], postedBy: 'hafid test', postedById: '1')];
  MockRemoteDS mockDS = MockRemoteDS();
  MockTokenRepo tokenRepo = MockTokenRepo();
  late PostsRepositoryImpl testRepo;

  setUp((){
    testRepo = PostsRepositoryImpl(remoteDataSource: mockDS,tokenRepo: tokenRepo);
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
  group('test add post feature', () {
    final postTest = PostModel(id: '1',description: "Eu fugiat veniam reprehenderit do incididunt officia.", title: 'test post 1', date: '23-05-2024', proposalCount: 5, hiredCount: 0, duration: 'less than one month',durationId: '2', amount: 200.5, subjects: ["math","physics"], postedBy: 'hafid test', postedById: '1');
    final postParams = PostParams(title: 'test post 1',description: 'Eu fugiat veniam reprehenderit do incididunt officia.',amount: 200.5,duration: '2');
    test('should return added Post when datasource respond with this post', () async {
      //arrange
      when(()=>tokenRepo.readToken()).thenAnswer((_) async => 'testtoken');
      when(()=>mockDS.addNewPost(postParams,any())).thenAnswer((_) async =>postTest);
      //test
      final result = await testRepo.addNewPost(postParams);
      expect(result, isA<Right>());
      result.fold((l) => fail("shouldn't return a failure"), (r){
        expect(r,isA<Post>());
        expect(r.title, postParams.title);
        expect(r.description, postParams.description);
      });
    });
    test('should return a failure when datasource throw an exception', () async {
      //arrange
      when(()=>tokenRepo.readToken()).thenAnswer((_) async => 'testtoken');
      when(()=>mockDS.addNewPost(postParams,any())).thenThrow(ServerException());
      //test
      final result = await testRepo.addNewPost(postParams);
      expect(result, isA<Left>());
      result.fold((l) => expect(l,isA<Failure>())
         , (r){fail("shouldn't return a failure");
        
      });
    });
  });
}