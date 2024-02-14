import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/login_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/login_use_case.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';

class MockLoginRepository extends Mock implements LoginRepository{}
void main() {
  late LoginUseCase testlogin;
  MockLoginRepository trepo = MockLoginRepository();
  final params = Loginparams(email: 'testEmail@example.com', password: 'testpassword');
  setUp((){
    testlogin = LoginUseCase(repository: trepo);
  });
  test('should return true when repo store token and return true', () async {
    
    //arrange
    when(()=>trepo.getAndStoreToken(params)).thenAnswer((invocation) async=> Right('testtoken'));
    //act
    final res = await testlogin.tryLogin(params);
    //assert
    expect(res, Right(true));
  });
   
   test('should return Failure when repo   return Failure', () async {
    
    //arrange
    when(()=>trepo.getAndStoreToken(params)).thenAnswer((invocation) async=> Left(ServerFailure()));
    //act
    final res = await testlogin.tryLogin(params);
    //assert
    expect(res, Left(ServerFailure()));
  });
}