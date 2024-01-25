import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_prof_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_student_use_case.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/register_user_cubit.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';

class MockRegisterProfUC extends Mock implements RegisterProfUseCase {}
class MockRegisterStudentUC  extends Mock implements RegisterStudentUseCase{}
//class ProfParamsFake extends Fake implements ProfessorParams {}
void main() {
  const tProfEntity = ProfEntity(token: 'abcdefghtjkjdfdkfjdf', name: '',email: 'test@example.com');
  MockRegisterProfUC mockRegisterProfUC = MockRegisterProfUC();
  MockRegisterStudentUC mockRegisterStudentUC = MockRegisterStudentUC();
  ProfessorParams tProfParams = ProfessorParams(subjects: ['1','2','3'],email: tProfEntity.email,password: '123456789',name:tProfEntity.name);
  /*setUpAll(() {
    registerFallbackValue(ProfParamsFake());
  });*/
blocTest<RegisterUserCubit, RegisterUserState>(
  
  'emits [RegisterUserLoading,RegisterUserSuccess with token] when registerProfessor is called.',
  setUp: (){
    when(()=> mockRegisterProfUC.registerNewProf(tProfParams)).thenAnswer((_) async => Right(tProfEntity));
  },
  build: () => RegisterUserCubit(registerProfUC: mockRegisterProfUC,registerStudentUC: mockRegisterStudentUC),
  act: (cubit) => cubit.registerProfessor(params : tProfParams ),
  expect: () => <RegisterUserState>[RegisterUserLoading(),RegisterUserSuccess()],
  
);

blocTest<RegisterUserCubit, RegisterUserState>(
  
  'emits [RegisterUserLoading,RegisterUserError with token] when registerProfessor is called.',
  setUp: (){
    when(()=> mockRegisterProfUC.registerNewProf(tProfParams)).thenAnswer((_) async => Left(ServerFailure()));
  },
  build: () => RegisterUserCubit(registerProfUC: mockRegisterProfUC,registerStudentUC: mockRegisterStudentUC),
  act: (cubit) => cubit.registerProfessor(params : tProfParams ),
  expect: () => <RegisterUserState>[RegisterUserLoading(),RegisterUserError(message: RegisterUserCubit.mapFailureToMessage(ServerFailure()) )],
  
);
}