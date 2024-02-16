import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/login_use_case.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/login_cubit_dart_cubit.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';

class MockLoaginUseCase extends Mock implements LoginUseCase {}

void main() {
  Loginparams params =
      Loginparams(email: 'testEmailàexample.com', password: 'testpassword');
  MockLoaginUseCase mockUC = MockLoaginUseCase();
  blocTest(
      'should return [loginLoadingState,loginSuccessState] when usecase return true',
      setUp: (){
        when(()=>mockUC.tryLogin(params)).thenAnswer((_) async => const Right(true));
      },
      build: () => LoginCubitDartCubit(loginUC: mockUC),
      act: (cubit) => cubit.login(params),
      expect:()=><LoginCubitDartState>[LoginLoadingState(),LoginSuccessState()]);
  
  blocTest(
      'should return [loginLoadingState,loginFaildState(errormsg)] when usecase return failure',
      setUp: (){
        when(()=>mockUC.tryLogin(params)).thenAnswer((_) async =>  Left(UnauthenticatedFailure()));
      },
      build: () => LoginCubitDartCubit(loginUC: mockUC),
      act: (cubit) => cubit.login(params),
      expect:()=><LoginCubitDartState>[LoginLoadingState(),LoginErrorState(entredEmail: params.email,entredpassword: params.password,errorMessage: LoginCubitDartCubit.failureToErrorMsg(UnauthenticatedFailure()))]);
  
}
