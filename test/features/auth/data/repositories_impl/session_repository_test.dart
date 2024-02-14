import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/session_repository.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage{}
void main() {
  late SessionRepository sessionRepo ;
  late MockSecureStorage securestorage;
  String testToken ='abcdefrrr';
  setUp((){
    securestorage = MockSecureStorage();
    sessionRepo = SessionRepository(secureStorage: securestorage );
  });

  test('should store key value', () async {
    
    when(()=>securestorage.write(key: 'user-token', value: 'testkey')).thenAnswer((_) async {});
    //test
    await sessionRepo.storeToken('testkey');
    //assert
    verify(()=>securestorage.write(key: 'user-token', value: 'testkey')).called(1);   
  });

  test('should read key value', () async {
    
    when(()=>securestorage.read(key: 'user-token')).thenAnswer((_) async => 'testkey');
    //test
    final token = await sessionRepo.readToken();
    //assert
    expect(token, 'testkey');
     
  });

  test('should throw storelocalexception', () async {
    
    when(()=>securestorage.write(key: 'user-token', value: 'testkey')).thenThrow(StoreLocalException());
    //test
    final call = sessionRepo.storeToken;
    //assert
    expect(()=>call('testkey'), throwsA(TypeMatcher<StoreLocalException>()));   
  });

  test('should should throw a ReadLocalException', () async {
    
    when(()=>securestorage.read(key: 'user-token')).thenThrow(ReadLocalException());
    //test
    final call = await sessionRepo.readToken;
    //assert
    expect(()=>call(), throwsA(TypeMatcher<ReadLocalException>()));   
     
  });
}