

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';

class TokenRepository {
  String _TOKEN_KEY = 'user-token';
final FlutterSecureStorage secureStorage;

  TokenRepository({required this.secureStorage});


Future<String?> readToken() async
{
  // Create storage

  try {
  final token = await secureStorage.read(key: _TOKEN_KEY); 
  //TODO : return token not hardcoded one
  return 'b2910daa07550a052f2e651670ef97fae0ca04fe';
  return token;
} on Exception catch (e) {
  throw ReadLocalException();
}
}

Future<void> storeToken(String token) async
{
  try {
  
  await secureStorage.write(key: _TOKEN_KEY, value: token);
} on Exception catch (e) {
 throw StoreLocalException();
}
}
}