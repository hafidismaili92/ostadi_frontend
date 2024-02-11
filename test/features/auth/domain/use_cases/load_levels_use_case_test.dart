

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/level_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_levels_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_levels_use_case.dart';
import 'package:test/test.dart';

class MockLoadLevelsRepository extends Mock implements LoadLevelsRepository{}
void main() {
  late LoadLevelsUseCase testLoadLevelsUC;

  MockLoadLevelsRepository repository = MockLoadLevelsRepository();

  List<Level> levelsList = [
    Level(id: 1, title: 'test level 1'),
    Level(id: 2, title: 'test level 2'),
  ];
  setUp((){
    testLoadLevelsUC = LoadLevelsUseCase(repository: repository);
  });
  test('should return a list of levels when repository return this lest of level success',() async {
    //arrange
    when(()=>repository.loadLevels()).thenAnswer((_) async => Right(levelsList) );
    //test
    final res = await testLoadLevelsUC.loadLevels();

    //assert
    verify(()=>repository.loadLevels()).called(1);
    expect(res, Right(levelsList));
  });

   test('should return a failure when repository return failure',() async {
    //arrange
    when(()=>repository.loadLevels()).thenAnswer((_) async => Left(ServerFailure()) );
    //test
    final res = await testLoadLevelsUC.loadLevels();

    //assert
    verify(()=>repository.loadLevels()).called(1);
    expect(res, Left(ServerFailure()));
    verifyNoMoreInteractions(repository);
  });
}