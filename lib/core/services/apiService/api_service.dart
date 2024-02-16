import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class ApiService {
  Future<HttpResponse> getData(Uri url);
  Future<HttpResponse> postData(Uri url, Map<String, dynamic> body,[Map<String, String>? headers]);
}

class HttpResponse {
  final int statusCode;
  final String data;

  HttpResponse({required this.statusCode, required this.data});
}

class HttpApiService implements ApiService {
  final client = http.Client();
  @override
  Future<HttpResponse> getData(Uri url) async {
    
    final res = await client.get(url);
    return HttpResponse(data: res.body, statusCode: res.statusCode);
  }

  @override
  Future<HttpResponse> postData(Uri url, Map<String, dynamic> body, [Map<String,String>? headers]) async {
    final postHeaders = headers?? {'Content-type': 'application/json','accept':'application/json'};
    final res = await client.post(url,
        body: jsonEncode(body), headers: postHeaders);
    
    return HttpResponse(data: res.body, statusCode: res.statusCode);
  }
}
