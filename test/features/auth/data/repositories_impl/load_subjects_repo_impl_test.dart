import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/core/platform/connectionInfo.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/models/subject_model.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/load_subjects_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/subject_entity.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSourceImplementation {}
class MockConnectioninfo extends Mock implements Connectioninfo {}
void main() {

  late LoadSubjectsRepoImpl tloadsubjectsrepo;
  MockRemoteDataSource mockRemoteDtsrc = MockRemoteDataSource();
  MockConnectioninfo connectioninfo = MockConnectioninfo();
   List<SubjectModel> subjectsList = [
    SubjectModel(id: '1', title: 'test subject 1', icon: 'test icon 1'),
    SubjectModel(id: '2', title: 'test subject 2', icon: 'test icon 2'),
    SubjectModel(id: '3', title: 'test subject 3', icon: 'test icon 3')
  ];
  setUp(() => {
    tloadsubjectsrepo = LoadSubjectsRepoImpl(remoteDataSource: mockRemoteDtsrc,connectionInfo: connectioninfo)
  });
  group('when internet connection available', () { 

    setUp(() => {
      when(()=>connectioninfo.isConnected).thenAnswer((_) async=> true)
    });
    test('should return a Right(List of subjects ) when  remote datasource success and return list of subjects', () async {
    //arrange
    when(()=>mockRemoteDtsrc.loadSubjects()).thenAnswer((_) async => subjectsList);
    //test
    final res = await tloadsubjectsrepo.loadSubjects();
    //assert
    verify((){mockRemoteDtsrc.loadSubjects();});
    expect(res, Right(subjectsList));
  });
  test('should return a Failure when  remote datasource throws an exception', () async {
    //arrange
    when(()=>mockRemoteDtsrc.loadSubjects()).thenThrow(ServerException());
    //test
    final res = await tloadsubjectsrepo.loadSubjects();
    //assert
    verify((){mockRemoteDtsrc.loadSubjects();});
    expect(res,equals(Left(ServerFailure())));
  });

  });

   group('when internet connection not available', () { 

    setUp(() => {
      when(()=>connectioninfo.isConnected).thenAnswer((_) async=> false)
    });
    
  test('should return a ConnectionFailure when  remote datasource throws an error', () async {
    
    //test
    final res = await tloadsubjectsrepo.loadSubjects();
    
    //assert
    verifyNever((){mockRemoteDtsrc.loadSubjects();});
    expect(res,Left(ConnectionFailure()));
  });

  });
  
}