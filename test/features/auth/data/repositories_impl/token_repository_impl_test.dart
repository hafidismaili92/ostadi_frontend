import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/models/prof_model.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/authentication_repository_impl.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage{}
class MockAuthRemoteDS extends Mock implements AuthRemoteDataSourceImplementation{}

void main() {
  late TokenRepository tokenRepo ;
  late MockSecureStorage securestorage;
  late MockAuthRemoteDS tremoteDS;
  String testToken ='abcdefrrr';
  setUp((){
    securestorage = MockSecureStorage();
    tremoteDS = MockAuthRemoteDS();
    tokenRepo = TokenRepository(secureStorage: securestorage,);
  });

  test('should store key value', () async {
    
    when(()=>securestorage.write(key: 'user-token', value: 'testkey')).thenAnswer((_) async {});
    //test
    await tokenRepo.storeToken('testkey');
    //assert
    verify(()=>securestorage.write(key: 'user-token', value: 'testkey')).called(1);   
  });

  test('should read key value', () async {
    
    when(()=>securestorage.read(key: 'user-token')).thenAnswer((_) async => 'testkey');
    //test
    final token = await tokenRepo.readToken();
    //assert
    expect(token, 'testkey');
     
  });

  test('should throw storelocalexception', () async {
    
    when(()=>securestorage.write(key: 'user-token', value: 'testkey')).thenThrow(StoreLocalException());
    //test
    final call = tokenRepo.storeToken;
    //assert
    expect(()=>call('testkey'), throwsA(TypeMatcher<StoreLocalException>()));   
  });

  test('should should throw a ReadLocalException', () async {
    
    when(()=>securestorage.read(key: 'user-token')).thenThrow(ReadLocalException());
    //test
    final call = await tokenRepo.readToken;
    //assert
    expect(()=>call(), throwsA(TypeMatcher<ReadLocalException>()));   
     
  });

  
}