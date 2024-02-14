import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';

class SessionRepository {
String _TOKEN_KEY = 'user-token';
final FlutterSecureStorage secureStorage;

  SessionRepository({required this.secureStorage});
Future<String?> readToken() async
{
  // Create storage

  try {
  final token = await secureStorage.read(key: _TOKEN_KEY); 
  return token;
} on Exception catch (e) {
  throw ReadLocalException();
}
}
Future<void> storeToken(token) async
{
  try {
  
  await secureStorage.write(key: _TOKEN_KEY, value: token);
} on Exception catch (e) {
 throw StoreLocalException();
}
}
}