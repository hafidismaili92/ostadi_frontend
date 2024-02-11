import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/models/prof_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/student_model.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/register_user_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSourceImplementation {}


void main() {
  
  late RegisterUserRepoImpl tRepo;
  MockRemoteDataSource tremoteDS = MockRemoteDataSource();
  
  
   
  setUp(() {
     
      tRepo = RegisterUserRepoImpl(remoteDataSource: tremoteDS);
    });
  group('test register prof', () {
    ProfModel tprofModel = ProfModel(email: 'test@example.com', token: 'testtoken', name: 'test prof');
  ProfEntity tprofEntity = tprofModel;
    ProfessorParams params = ProfessorParams(email:'test@example.com',password:'testpassword',name:'test prof',subjects: ['1','2']);
    test('should return a Right(ProfEntity) when datasource return data succefully',() async {
    //arrange
    when(()=>tremoteDS.registerProf(params)).thenAnswer((_) async => tprofModel);
    //act
    final result = await tRepo.registerNewProfessor(params);
    
    //assert
    expect(result,equals(Right(tprofEntity)));

  });
  test('should return a Left(Failure) when datasource throw Exception',() async {
    //arrange
    when(()=>tremoteDS.registerProf(params)).thenThrow(ServerException());
    //act
    final result = await tRepo.registerNewProfessor(params);
    
    //assert
    verify((){tremoteDS.registerProf(params);});
    expect(result,isA<Left<Failure, ProfEntity>>());
   
  });
  });

  group('test register student', () {
    StudentModel tstudentModel = StudentModel(email: 'test@example.com', token: 'testtoken', name: 'test prof');
  StudentEntity tstudentEntity = tstudentModel;
    StudentParams params = StudentParams(email:'test@example.com',password:'testpassword',name:'test prof',level:'1');
    test('should return a Right(StudentEntity) when datasource return data succefully',() async {
    //arrange
    when(()=>tremoteDS.registerStudent(params)).thenAnswer((_) async => tstudentModel);
    //act
    final result = await tRepo.registerNewStudent(params);
    
    //assert
    expect(result,equals(Right(tstudentEntity)));

  });
  test('should return a Left(Failure) when datasource throw Exception',() async {
    //arrange
    when(()=>tremoteDS.registerStudent(params)).thenThrow(ServerException());
    //act
    final result = await tRepo.registerNewStudent(params);
    
    //assert
    verify((){tremoteDS.registerStudent(params);});
    expect(result,isA<Left<Failure, StudentEntity>>());
   
  });
  });
}