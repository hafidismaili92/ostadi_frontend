

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/posts_repository.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/add_job_post_uc.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';
import 'package:test/test.dart';

class MockPostsRepository extends Mock implements PostsRepository{}
void main() {
  late AddJobPostUseCase addjobUCTest;
  final postTest = Post(id: '1',description: "Eu fugiat veniam reprehenderit do incididunt officia.", title: 'test post 1', date: '23-05-2024', proposalCount: 5, hiredCount: 0, duration: 'less than one month',durationId: '2', amount: 200.5, subjects: ["math","physics"], postedBy: 'hafid test', postedById: '1');
  PostsRepository mockedrepository = MockPostsRepository();
  final postParams = PostParams(title: 'test post 1',description: 'Eu fugiat veniam reprehenderit do incididunt officia.',amount: 200.5,duration: '2');
  setUp((){
addjobUCTest = AddJobPostUseCase(repository: mockedrepository);
  });
  test('when user call add job post usecase, it should return the added post when the repository respond with this post', () async {
    //arrange
    when(() => mockedrepository.addNewPost(postParams)).thenAnswer((_) async => Right(postTest));
    //act
    final result = await addjobUCTest.execute(postParams);
    //assert
    expect(result, isA<Right>());
    result.fold(
      (l)=>fail('Expected a Right but got a Left'),
      (r){
        expect(r,isA<Post>());
         expect(r.title, postParams.title);
        expect(r.description, postParams.description);
      }
    );
   
  });
  test('should return a failure where repo return a failure', () async {
     //arrange
    when(() => mockedrepository.addNewPost(postParams)).thenAnswer((_) async => Left(ServerFailure()));
    //act
    final result = await addjobUCTest.execute(postParams);
    //assert
    expect(result, isA<Left>());
    result.fold((l) {expect(l,isA<Failure>());}, (r) => fail('unexcpected post returned from uc'));
  });
}