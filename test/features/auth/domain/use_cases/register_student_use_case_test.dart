import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';

import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_student_use_case.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

class MockRegisterUserRepo extends Mock implements RegisterUserRepo {}
void main() {
  late MockRegisterUserRepo trepository;
  late RegisterStudentUseCase tCreateStudentUC;
  StudentEntity tuserEntity= StudentEntity(level: '1',email:'test@example.com',avatar: 'test avatar', name: 'test student');
  StudentParams params = StudentParams(email:'test@example.com',password:'testpassword',name:'test student',level:'1');

  setUp(() {
trepository = MockRegisterUserRepo();
tCreateStudentUC = RegisterStudentUseCase(repository: trepository);
  });
  test('should return a userEntity when call to repository return this userEntity',() async {

    //arrange
    when(()=> trepository.registerNewStudent(params)).thenAnswer((_) async => Right(tuserEntity) );
    //act
    final result = await tCreateStudentUC.registerNewStudent(params);
    //assert
    verify(()=>trepository.registerNewStudent(params)).called(1);
    expect(result, Right(tuserEntity));
    verifyNoMoreInteractions(trepository);
  });

   test('should return a  Failure when call to repository return  Failure',() async {

    //arrange
    when(()=> trepository.registerNewStudent(params)).thenAnswer((_) async => Left(ServerFailure()) );
    //act
    final result = await tCreateStudentUC.registerNewStudent(params);
    //assert
    verify(()=>trepository.registerNewStudent(params)).called(1);
   expect(result, isA<Left<Failure, StudentEntity>>());
    verifyNoMoreInteractions(trepository);
  });

}

