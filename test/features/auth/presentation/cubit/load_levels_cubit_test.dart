import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/level_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_levels_use_case.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/load_levels_cubit.dart';

class MockLoadLevelsUseCase extends Mock implements LoadLevelsUseCase{}
void main() {
  List<Level> levelsList = [
    Level(id: 1, title: 'test Level 1'),
    Level(id: 2, title: 'test Level 2'),
    Level(id: 3, title: 'test Level 3')
  ];
  MockLoadLevelsUseCase loadLevelsUC  = MockLoadLevelsUseCase();
 blocTest<LoadLevelsCubit,LoadLevelsState>('should emits a [LoadLevelsLoading, LoadLevelssuccess with Levels list] when use case called and it return a list of Levels', setUp: (){
    when(()=> loadLevelsUC.loadLevels()).thenAnswer((_) async => Right(levelsList));
  },build:()=>LoadLevelsCubit(loadLevelsUC: loadLevelsUC),act: (cubit)=>cubit.loadLevels(),expect:()=> <LoadLevelsState>[LoadLevelsLoading(),LoadLevelsSuccess(levels: levelsList)] );

blocTest<LoadLevelsCubit,LoadLevelsState>('should emits a [LoadLevelsLoading, LoadLevelsError with error msg] when use case return a failure', setUp: (){
    when(()=> loadLevelsUC.loadLevels()).thenAnswer((_) async => Left(ServerFailure()));
  },build:()=>LoadLevelsCubit(loadLevelsUC: loadLevelsUC),act: (cubit)=>cubit.loadLevels(),expect:()=> <LoadLevelsState>[LoadLevelsLoading(),LoadLevelsError(errorMessage: 'error from Server')] );

}