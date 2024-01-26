import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';

import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_prof_use_case.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';


class MockRegisterUserRepo extends Mock implements RegisterUserRepo {}
void main() {
  late MockRegisterUserRepo trepository;
  late RegisterProfUseCase trgprofUC;
  const ProfEntity tprofEntity= ProfEntity(email:'test@example.com',token: 'test token', name: 'test student');
  ProfessorParams params = ProfessorParams(email:'test@example.com',password:'testpassword',name:'test student',subjects: ['1','2']);

  setUp(() {
trepository = MockRegisterUserRepo();
trgprofUC = RegisterProfUseCase(repository: trepository);
  });
  test('should return a ProfessorEntity when call to repository return this ProfessorEntity',() async {

    //arrange
    when(()=> trepository.registerNewProfessor(params)).thenAnswer((_) async => const Right(tprofEntity) );
    //act
    final result = await trgprofUC.registerNewProf(params);
    //assert
    verify(()=>trepository.registerNewProfessor(params)).called(1);
    expect(result, Right(tprofEntity));
    verifyNoMoreInteractions(trepository);
  });

   test('should return a  Failure when call to repository return  Failure',() async {

    //arrange
    when(()=> trepository.registerNewProfessor(params)).thenAnswer((_) async => Left(ServerFailure()) );
    //act
    final result = await trgprofUC.registerNewProf(params);
    //assert
    verify(()=>trepository.registerNewProfessor(params)).called(1);
   expect(result, isA<Left<Failure, ProfEntity>>());
    verifyNoMoreInteractions(trepository);
  });

}

