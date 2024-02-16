import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/core/platform/connectionInfo.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/login_repository_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/session_repository.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';


class MockRemoteDataSource extends Mock implements AuthRemoteDataSourceImplementation {}
class MockSessionRepository extends Mock implements SessionRepository{}
class MockConnectioninfo extends Mock implements Connectioninfo {}
void main() {
  late LoginRepositoryImplementation tRepo;
  MockRemoteDataSource tremoteDS = MockRemoteDataSource();
  MockSessionRepository mocksessionRepo = MockSessionRepository();
  MockConnectioninfo connectioninfo = MockConnectioninfo();
  final params = Loginparams(email: 'testEmail@example.com', password: 'testpassword');
  setUp((){
tRepo = LoginRepositoryImplementation(connectionInfo: connectioninfo ,remoteDataSource: tremoteDS,sessionRepository: mocksessionRepo);
  });
  test('should  store token using sessionRepository and return the token when datasource return token succefully',() async {
    //arrange
    when(()=>tremoteDS.getToken(params)).thenAnswer((_) async =>'testtoken');
    when(()=>mocksessionRepo.storeToken(any())).thenAnswer((_) async =>{});
    //act
    final result = await tRepo.getAndStoreToken(params);
    
    //assert
    expect(result,Right('testtoken'));

  });
  test('should  return UnauthenticatedFailure when remote datasource throw a Unauthenticated exception',() async {
    //arrange
    when(()=>tremoteDS.getToken(params)).thenThrow(UnauthenticatedException());
    //act
    final result = await tRepo.getAndStoreToken(params);
    
    //assert
    expect(result,Left(UnauthenticatedFailure()));

  });

  group('when internet connection not available', () { 

    setUp(() => {
      when(()=>connectioninfo.isConnected).thenAnswer((_) async=> false)
    });
    
  test('should return a ConnectionFailure when  remote datasource throws an error', () async {
    
    //test
    final res = await tRepo.getAndStoreToken(params);
    
    //assert
    verifyNever((){tremoteDS.getToken(params);});
    expect(res,Left(ConnectionFailure()));
  });

  });
}