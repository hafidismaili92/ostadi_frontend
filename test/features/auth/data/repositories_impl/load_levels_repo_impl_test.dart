import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/core/platform/connectionInfo.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/models/level_model.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/load_levels_repo_impl.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/level_entity.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSource{}
class MockConnectioninfo extends Mock implements Connectioninfo {}
void main() {
  late LoadLevelsRepoImpl testRepository;
  MockRemoteDataSource remoteDS = MockRemoteDataSource();
   MockConnectioninfo connectioninfo = MockConnectioninfo();
  List<LevelModel> levelsList = [
    LevelModel(id: 1, title: 'test subject 1',),
    LevelModel(id: 2, title: 'test subject 2',),
    LevelModel(id: 3, title: 'test subject 3',)
  ];
  List<Level> levelsEntitties = levelsList;
  setUp(() {
    testRepository = LoadLevelsRepoImpl(remoteDataSource: remoteDS,connectionInfo: connectioninfo);
  });
  group('internet connection available', () {
    setUp(() => {
      when(()=>connectioninfo.isConnected).thenAnswer((_) async=> true)
    });
    test('repo should return à right(list of levels) when remote datasource respond with list of levels models',() async {
    //arrange
    when(()=>remoteDS.loadLevels()).thenAnswer((_) async => levelsList);
    //test
    final res = await testRepository.loadLevels();
    verify((){remoteDS.loadLevels();});
    expect(res, Right(levelsEntitties));
  });
  test('repo should return à failure when remote datasource throws an exception',() async {
    //arrange
    when(()=>remoteDS.loadLevels()).thenThrow(ServerException());
    //test
    final res = await testRepository.loadLevels();
    verify((){remoteDS.loadLevels();});
    expect(res, Left(ServerFailure()));
  });
  });

  group('when internet connection not available', () { 

    setUp(() => {
      when(()=>connectioninfo.isConnected).thenAnswer((_) async=> false)
    });
    
  test('should return a ConnectionFailure when  remote datasource throws an error', () async {
    
    //test
    final res = await testRepository.loadLevels();
    
    //assert
    verifyNever((){remoteDS.loadLevels();});
    expect(res,Left(ConnectionFailure()));
  });

  });
}