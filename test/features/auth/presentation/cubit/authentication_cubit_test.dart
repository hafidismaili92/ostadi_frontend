import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/get_authenticated_User.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';

class MockAutUC extends Mock implements GetAuthenticatedUserUC{}
void main() {
  MockAutUC Mockusecase = MockAutUC();
  AuthenticatedUserEntity user = AuthenticatedUserEntity(isDefaultStudent: false, isProfessor: true, isStudent: false, email: 'testemail@example.com', avatar: 'ff.jpg', name: 'ism test');
  blocTest('should emit [authentificationLoading,authentificationSuccess(user)] when uc return a userEntity', setUp: (){
    when(()=>Mockusecase.getAuthenticadedUser()).thenAnswer((_) async => Right(user));
  }, build:() =>AuthenticationCubit(getAuthenticatedUserUC: Mockusecase),
  act: (cubit)=>cubit.getAuthenticatedUser(),
  expect: () => <AuthenticationState>[AuthenticationLoading(),AuthenticationSuccess(user: user)],
  );

  blocTest('should emit [authentificationLoading,authentificationError(UnauthenticatedMsg)] when uc return a UnauthenticatedFailure', setUp: (){
    when(()=>Mockusecase.getAuthenticadedUser()).thenAnswer((_) async => Left(UnauthenticatedFailure()));
  }, build:() =>AuthenticationCubit(getAuthenticatedUserUC: Mockusecase),
  act: (cubit)=>cubit.getAuthenticatedUser(),
  expect: () => <AuthenticationState>[AuthenticationLoading(),AuthenticationError(errorMsg: AuthenticationCubit.failureToErrorMsg(UnauthenticatedFailure()))],
  );
   blocTest('should emit [authentificationLoading,authentificationError(ServerFailureMsg)] when uc return a ServerFailure', setUp: (){
    when(()=>Mockusecase.getAuthenticadedUser()).thenAnswer((_) async => Left(ServerFailure()));
  }, build:() =>AuthenticationCubit(getAuthenticatedUserUC: Mockusecase),
  act: (cubit)=>cubit.getAuthenticatedUser(),
  expect: () => <AuthenticationState>[AuthenticationLoading(),AuthenticationError(errorMsg: AuthenticationCubit.failureToErrorMsg(ServerFailure()))],
  );
}