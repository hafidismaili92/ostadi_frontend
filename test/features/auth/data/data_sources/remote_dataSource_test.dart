import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/constants/api.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/models/level_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/student_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/subject_model.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';
import 'package:test/test.dart';

class MockApiService extends Mock implements ApiService {}
class FakeUri extends Fake implements Uri {}

void main() {
  late AuthRemoteDataSourceImplementation remotedsImpl;
  MockApiService apiService = MockApiService();

  setUp(() {
    remotedsImpl = AuthRemoteDataSourceImplementation(apiservice: apiService);


  });
  group('test subjects', () {
    
    const String subjectsDataString =
        """[
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
    setUp(() {
     
      final datajson = jsonDecode(subjectsDataString);
      for (var subject in datajson) {
        subjectsModels.add(SubjectModel.fromJson(subject));
      }
    });
    test(
        'should return a list of subject Models when api send a valid subjects json string',
        () async {
      //arrange
      when(() => apiService.getData(Uri.parse('$BASE_URL/${AuthRemoteDataSourceImplementation.subjectsEndPoint}'))).thenAnswer(
          (_) async => HttpResponse(statusCode: 200, data: subjectsDataString));
      //test
      final res = await remotedsImpl.loadSubjects();

      expect(res, subjectsModels);
    });

    test('should return a server error when api send a status != 200',
        () async {
      //arrange
      when(() => apiService.getData(Uri.parse('$BASE_URL/${AuthRemoteDataSourceImplementation.subjectsEndPoint}')))
          .thenAnswer((_) async => HttpResponse(statusCode: 401, data: ''));
      //test
      final call = remotedsImpl.loadSubjects;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('test levels', () {
     const String levelsDataString =
        """[
  {
    "id": 1,
    "title": "Early childhood"
  },
  {
    "id": 2,
    "title": "primary"
  },
  {
    "id": 3,
    "title": "secondary"
  },
  {
    "id": 4,
    "title": "University"
  },
  {
    "id": 5,
    "title": "Other"
  }
]""";
    List<LevelModel> levelsModels = [];

    setUp(() {
     
      final datajson = jsonDecode(levelsDataString);
      for (var level in datajson) {
        levelsModels.add(LevelModel.fromJson(level));
      }
    });
  
    test('should return a list of level models when remote api service respond with 200 status code and  a string json of levels', () async {
      //arrange
      when(()=>apiService.getData(Uri.parse('$BASE_URL/${AuthRemoteDataSourceImplementation.levelsEndPoint}'))).thenAnswer((_) async { return HttpResponse(statusCode: 200, data: levelsDataString);});
      //test
    final res = await remotedsImpl.loadLevels();
    expect(res,levelsModels);
    });

    test('should throw a serverException when response is differet from 200 status code', ()  {
      //arrange
      when(()=>apiService.getData(Uri.parse('$BASE_URL/${AuthRemoteDataSourceImplementation.levelsEndPoint}'))).thenAnswer((_) async { return HttpResponse(statusCode: 401, data: '');});
      //test
    final call = remotedsImpl.loadLevels;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
    
  });

  group('test add user', (){

    test('add new student',(){
      StudentParams studentparams = StudentParams(level: '1', email: 'teststudent@gmail.com', password: '123456789', name: 'test student');
      String StudentModelString = '{email:"testemail@example.com"}';
      //test 
      final res = remotedsImpl.registerStudent(studentparams);
    });
  });
}
