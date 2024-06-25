import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/my_posts_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/models/post_model.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';


class MockApiService extends Mock implements ApiService {}
class FakeUri extends Fake implements Uri {}
void main() {
  
  MockApiService apiService = MockApiService();
  late PostsRemoteDataSource tDataSource;
  const myPostsString = """[{
  "id": 17,
  "student": {
    "id": 15,
    "user": {
      "id": 24,
      "name": "studentAccount"
    }
  },
  "subjects": [],
  "title": "test title",
  "description": "test description",
  "amount": "400.20",
  "date": "2024-06-24T14:10:34.011403Z",
  "duration": {
    "id": 2,
    "duration": "1-3 months"
  }
}]""";
  setUp((){
    tDataSource = PostsRemoteDataSource(apiservice: apiService);
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

  group('test add post to datasource feature', () {
   
    final postString = """{
  "id": 17,
  "student": {
    "id": 15,
    "user": {
      "id": 24,
      "name": "studentAccount"
    }
  },
  "subjects": [],
  "title": "test post 1",
  "description": "Eu fugiat veniam reprehenderit do incididunt officia.",
  "amount": "200.5",
  "date": "2024-06-24T14:10:34.011403Z",
  "duration": {
    "id": 2,
    "duration": "1-3 months"
  }
}""";
    //final postTest = PostModel(id: '1',description: "Eu fugiat veniam reprehenderit do incididunt officia.", title: 'test post 1', date: '23-05-2024', proposalCount: 5, hiredCount: 0, duration: 'less than one month',durationId: '2', amount: 200.5, subjects: ["math","physics"], postedBy: 'hafid test', postedById: '1');
    final postParams = PostParams(title: 'test post 1',description: 'Eu fugiat veniam reprehenderit do incididunt officia.',amount: 200.5,duration: '2');
    final postStringToJson = jsonDecode(postString);
    test('should return a newly created PostModel when apiService responds with a 201 status code', () async {
        //arrange
        when(()=>apiService.postData(any(), any(),any())).thenAnswer((_) async =>  HttpResponse(data:postString,statusCode:201));
        //test
        final result = await tDataSource.addNewPost(postParams,'');
        //assert
        
        expect(result, isA<PostModel>());
        expect(result.title, postStringToJson['title']);
        expect(result.description, postStringToJson['description']);
    });
    test('should throw a server exception when api respond with statuscode !=201', () async {
        //arrange
        when(()=>apiService.postData(any(), any(),any())).thenAnswer((_) async =>  HttpResponse(data:'',statusCode:500));
        //test
        final call = tDataSource.addNewPost;
        //assert
        
        expect(()=>call(postParams,''),throwsA(TypeMatcher<ServerException>()));
        
    });
  });
}