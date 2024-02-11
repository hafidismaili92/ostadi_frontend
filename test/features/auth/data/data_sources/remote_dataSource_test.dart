import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/models/subject_model.dart';
import 'package:test/test.dart';


class MockApiService extends Mock implements ApiService {}
void main() {
  late AuthRemoteDataSourceImplementation remotedsImpl;
  MockApiService apiService = MockApiService();
  const String subjectsDataString = """[
  {
    "id": 1,
    "title": "math",
    "icon": "http://127.0.0.1:8000/media/images/subjects/math_ie0ifos.png"
  },
  {
    "id": 2,
    "title": "arabic",
    "icon": "http://127.0.0.1:8000/media/images/subjects/arabic_0xOTR6b.png"
  },
  {
    "id": 3,
    "title": "Physics",
    "icon": "http://127.0.0.1:8000/media/images/subjects/physics_ieDaClh.png"
  },
  {
    "id": 4,
    "title": "computer science",
    "icon": "http://127.0.0.1:8000/media/images/subjects/programming_dhr2mhp.png"
  },
  {
    "id": 5,
    "title": "chemistry-biology",
    "icon": "http://127.0.0.1:8000/media/images/subjects/svt_A1IFia7.png"
  }
]""";
List<SubjectModel> subjectsModels = [];

  setUp((){
remotedsImpl = AuthRemoteDataSourceImplementation(apiservice: apiService );
final datajson = jsonDecode(subjectsDataString);
//register uri.parse for mocktail so that we can use any()
registerFallbackValue(Uri.parse(''));


for (var subject  in datajson) {
  
  subjectsModels.add(SubjectModel.fromJson(subject));
}

  });
  test('should return a list of subject Models when api send a valid subjects json string', () async {
    //arrange
    when(()=>apiService.getData(any())).thenAnswer((_) async => HttpResponse(statusCode: 200, data: subjectsDataString));
  //test
  final res = await remotedsImpl.loadSubjects();   
 
  expect(res, subjectsModels);
  });

  test('should return a server error when api send a status != 200', () async {
    //arrange
    when(()=>apiService.getData(any())).thenAnswer((_) async => HttpResponse(statusCode: 401, data: ''));
  //test
  final call = remotedsImpl.loadSubjects;   
 
  expect(()=>call(), throwsA(TypeMatcher<ServerException>()));
  });
}