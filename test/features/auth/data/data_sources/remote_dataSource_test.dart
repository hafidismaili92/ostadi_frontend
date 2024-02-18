import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/constants/api.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/models/authenticated_user_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/level_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/prof_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/student_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/subject_model.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
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
  setUpAll((){
      // to enable use any on Uri class
      registerFallbackValue(Uri());
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
    
    test('add new student success',() async{
      StudentParams studentparams = StudentParams(level: '1', email: 'dfff@example.com', password: '123456789', name: 'test student');
      Map<String,dynamic> studentModelJson = {"email": studentparams.email };
      StudentModel tstudentmodel = StudentModel.fromJson(studentModelJson);
      //arrange
      when(()=>apiService.postData(any(), studentparams.toJson())).thenAnswer((_) async => HttpResponse(statusCode: 201, data: jsonEncode(studentModelJson)));
      //test 

      final res = await remotedsImpl.registerStudent(studentparams);
      
      //assert
      expect(res, tstudentmodel);
    });

    test('add new professpr success',() async{
      ProfessorParams profparams = ProfessorParams(subjects: ['1','2'], email: 'dfff@example.com', password: '123456789', name: 'test student');
      Map<String,dynamic> profModelJson = {"email":  profparams.email };
      ProfModel tprofmodel = ProfModel.fromJson(profModelJson);
      
      //arrange
      when(()=>apiService.postData(any(), profparams.toJson())).thenAnswer((_) async => HttpResponse(statusCode: 201, data: jsonEncode(profModelJson)));
      //test 

      final res = await remotedsImpl.registerProf(profparams);
      
      //assert
      expect(res, tprofmodel);
    });
    test('add new student failed',() {
      StudentParams studentparams = StudentParams(level: '1', email: 'teststudent@gmail.com', password: '123456789', name: 'test student');
      Map<String,dynamic> studentModelJson = {"email": studentparams.email };
      
      //arrange
      when(()=>apiService.postData(any(), studentparams.toJson())).thenAnswer((_) async => HttpResponse(statusCode: 400, data: ''));
      //test 
      final call = remotedsImpl.registerStudent;
      
      //assert
      expect(()=> call(studentparams), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('test get token', () {
    test('should return token response when sevrer response success', () async {
      //arrange
      final loginparams = Loginparams(email: 'test@example.com', password: 'testpassword');
       when(()=>apiService.postData(any(), loginparams.toJson())).thenAnswer((_) async => HttpResponse(statusCode: 200, data: 'tokentest'));
      //test
      final res = await remotedsImpl.getToken(loginparams);
      expect(res, 'tokentest');
    });

    test('should throw Unauthrized exception when server respond with 401 Unauthorized status', ()  {
      //arrange
      final loginparams = Loginparams(email: 'test@example.com', password: 'testpassword');
       when(()=>apiService.postData(any(), loginparams.toJson())).thenAnswer((_) async => HttpResponse(statusCode: 401, data: ''));
      //test
      final call = remotedsImpl.getToken;
      expect(()=>call(loginparams), throwsA(TypeMatcher<UnauthenticatedException>()));
    });
    test('should throw server exception when server respond with status !=200 and != 401', ()  {
      //arrange
      final loginparams = Loginparams(email: 'test@example.com', password: 'testpassword');
       when(()=>apiService.postData(any(), loginparams.toJson())).thenAnswer((_) async => HttpResponse(statusCode: 500, data: ''));
      //test
      final call = remotedsImpl.getToken;
      expect(()=>call(loginparams), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('test authentication', () {
    const String userDataString = """
{
  "name": "profAccount",
  "email": "prof@example.com",
  "avatar":"avatar.jpg",
  "is_default_student": false,
  "is_student": false,
  "is_professor": true
}
""";
final userModel = AuthenticatedUserModel.fromJson(jsonDecode(userDataString));
    test('should return a UserModel(ProfModel) when apiService respond with 200 status and Prof Data', () async {
      //assert
      when(()=>apiService.getData(any(),{'Authorization':'testtoken'})).thenAnswer((invocation) async => HttpResponse(statusCode: 200, data: userDataString));
      //act
      final res = await remotedsImpl.getAuthenticatedUser('testtoken');
      print(res);
      expect(res, userModel);
    });

    test('should throw UnAuthenticatedException when apiService respond with status < 500 and > 399', () {
      //assert
      when(()=>apiService.getData(any(),{'Authorization':'Token testtoken'})).thenAnswer((invocation) async => HttpResponse(statusCode: 401, data:''));
      //act
      final call = remotedsImpl.getAuthenticatedUser;
      //assert
      expect(()=>call('testtoken'), throwsA(TypeMatcher<UnauthenticatedException>()));
    });
    test('should throw ServerException when apiService respond with status >= 500 or <= 399', () {
      //assert
      when(()=>apiService.getData(any(),{'Authorization':'Token testtoken'})).thenAnswer((invocation) async => HttpResponse(statusCode: 500, data:''));
      //act
      final call = remotedsImpl.getAuthenticatedUser;
      //assert
      expect(()=>call('testtoken'), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
