import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/subject_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_subjects_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_subjects_use_case.dart';

class MockLoadSubjectsRepo extends Mock implements LoadSubjectsRepository {}


void main() {
  late LoadSubjectsUseCase loadSubjectsUC;
  MockLoadSubjectsRepo mockRepository = MockLoadSubjectsRepo();
  List<Subject> subjectsList = [
    Subject(id: '1', title: 'test subject 1', icon: 'test icon 1'),
    Subject(id: '2', title: 'test subject 2', icon: 'test icon 2'),
    Subject(id: '3', title: 'test subject 3', icon: 'test icon 3')
  ];
  setUp(() {
    loadSubjectsUC = LoadSubjectsUseCase(repository: mockRepository);
  });
  test('return subjects list success when repo respond with list of subjects', () async {
    //arrange
    when(()=>mockRepository.loadSubjects()).thenAnswer((_) async  =>  Right(subjectsList) );
    //act
    final res = await loadSubjectsUC.loadSubjects();
    //assert
    verify(()=>mockRepository.loadSubjects()).called(1);
    expect(res,Right(subjectsList));
  });
  test('return Failure  when repo respond with Failure', () async {
    //arrange
    when(()=>mockRepository.loadSubjects()).thenAnswer((_) async  =>  Left(ServerFailure()) );
    //act
    final res = await loadSubjectsUC.loadSubjects();
    //assert
    verify(()=>mockRepository.loadSubjects()).called(1);
    expect(res,isA<Left<Failure,List<Subject>>>());
  });
}