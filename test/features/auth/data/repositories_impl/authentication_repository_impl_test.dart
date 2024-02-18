import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/models/prof_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/authenticated_user_model.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/authentication_repository_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/authentication_repository.dart';


class MockAuthRemoteDS extends Mock implements AuthRemoteDataSourceImplementation{}
class MockTokenRepo extends Mock implements TokenRepository{}
void main() {
  MockAuthRemoteDS tremoteDS = MockAuthRemoteDS();
  MockTokenRepo tokenRepo = MockTokenRepo();
  late AuthenticationRepositoryImpl repoTotest;
  setUp((){
repoTotest = AuthenticationRepositoryImpl(remoteDS: tremoteDS, tokenRepo: tokenRepo);
  });
  group('test get authenticated user ', () {
    final userModel = AuthenticatedUserModel(email: 'test email',avatar: 'testavatar.pgn',name: 'testname',isDefaultStudent: false,isProfessor: true,isStudent: false);
    final AuthenticatedUserEntity userEntity = userModel ;
    test('should return AuthenticatedUserEntity when datasource return res success with user', () async {
//arrange
when(()=>tremoteDS.getAuthenticatedUser(any())).thenAnswer((_) async => userModel);
when(()=>tokenRepo.readToken()).thenAnswer((_) async => 'testtoken');
      //test
      final res = await repoTotest.getAuthenticatedUser();
      //assert
      expect(res, Right(userEntity));
    });
    test('should return NoTokenRegistredFailure where no key registred in the system ', () async {
//arrange
when(()=>tremoteDS.getAuthenticatedUser(any())).thenAnswer((_) async => userModel);
when(()=>tokenRepo.readToken()).thenAnswer((_) async => null);
      //test
      final res = await repoTotest.getAuthenticatedUser();
      //assert

      expect(res, Left(NoTokenRegistredFailure()));
      verifyNever(()=>tremoteDS.getAuthenticatedUser(any()));
    });
     test('should return Unauthenticated Failure where remoteDS respond with Unauthenticated Exception ', () async {
//arrange
when(()=>tremoteDS.getAuthenticatedUser(any())).thenThrow(UnauthenticatedException());
when(()=>tokenRepo.readToken()).thenAnswer((_) async => 'testToken');
      //test
      final res = await repoTotest.getAuthenticatedUser();
      //assert

      expect(res, Left(UnauthenticatedFailure()));
      
    });
  });
}