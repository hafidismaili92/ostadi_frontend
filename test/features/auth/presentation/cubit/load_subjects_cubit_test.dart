import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/subject_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_subjects_use_case.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/load_subjects_cubit.dart';

class MockLoadSubjectsUseCase extends Mock implements LoadSubjectsUseCase{}
void main() {
  List<Subject> subjectsList = [
    Subject(id: 1, title: 'test subject 1', icon: 'test icon 1'),
    Subject(id: 2, title: 'test subject 2', icon: 'test icon 2'),
    Subject(id: 3, title: 'test subject 3', icon: 'test icon 3')
  ];
  MockLoadSubjectsUseCase loadSUbjectsUC  = MockLoadSubjectsUseCase();
 blocTest<LoadSubjectsCubit,LoadSubjectsState>('should emits a [LoadSubjectsLoading, LoadSubjectssuccess with subjects list] when use case called and it return a list of subjects', setUp: (){
    when(()=> loadSUbjectsUC.loadSubjects()).thenAnswer((_) async => Right(subjectsList));
  },build:()=>LoadSubjectsCubit(loadSUbjectsUC: loadSUbjectsUC),act: (cubit)=>cubit.loadSubjects(),expect:()=> <LoadSubjectsState>[LoadSubjectsLoading(),LoadSubjectsSuccess(subjects: subjectsList)] );

blocTest<LoadSubjectsCubit,LoadSubjectsState>('should emits a [LoadSubjectsLoading, LoadSubjectsError with error msg] when use case return a failure', setUp: (){
    when(()=> loadSUbjectsUC.loadSubjects()).thenAnswer((_) async => Left(ServerFailure()));
  },build:()=>LoadSubjectsCubit(loadSUbjectsUC: loadSUbjectsUC),act: (cubit)=>cubit.loadSubjects(),expect:()=> <LoadSubjectsState>[LoadSubjectsLoading(),LoadSubjectsError(errorMessage: 'error from Server')] );

}