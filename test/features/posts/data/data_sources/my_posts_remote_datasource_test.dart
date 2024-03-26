import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/my_posts_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/models/post_model.dart';


class MockApiService extends Mock implements ApiService {}
class FakeUri extends Fake implements Uri {}
void main() {
  
  MockApiService apiService = MockApiService();
  late MyPostsRemoteDataSource tDataSource;
  const myPostsString = """[{
    "id": 0,
    "title": "test post 1",
    "description": "test post 1 description",
    "amount": 300,
    "date": "2024-03-21T10:10:06.358Z",
    "duration": "less than 1 month",
    "student": 3,
    "postedBy":"hafid test",
    "subjects": [
      "science computer"
    ]
  },{
    "id": 0,
    "title": "test post 2",
    "description": "test post 2 description",
    "amount": 500,
    "date": "2024-03-21T10:10:06.358Z",
    "duration": "less than 1 month",
    "postedBy":"hafid test",
    "student": 3,
    "subjects": [
      "math","physics"
    ]
  }]""";
  setUp((){
    tDataSource = MyPostsRemoteDataSource(apiservice: apiService);
  });

  setUpAll((){
      // to enable use any on Uri class
      registerFallbackValue(Uri());
      registerFallbackValue(<String, String>{});
    });
  test('should respond with a list of posts models when server response whit code status 200 ',() async {
    
  List<PostModel> expectedPosts = [];
  final datajson = jsonDecode(myPostsString);
  for (var post in datajson) {
        expectedPosts.add(PostModel.fromJson(post));
      }
   
    //assert
    when(()=>apiService.getData(any(),any())).thenAnswer((invocation) async => HttpResponse(statusCode: 200, data: myPostsString));
    //act
    final result = await tDataSource.loadMyPosts('tokentest');
    //assert
    expect(result, expectedPosts);
  });
}