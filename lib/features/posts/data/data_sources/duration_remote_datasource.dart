import 'dart:convert';

import 'package:ostadi_frontend/core/constants/api.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/posts/data/models/duration_model.dart';

class DurationRemoteDataSource
{
  final ApiService apiservice;

  DurationRemoteDataSource({required this.apiservice});

  Future<List<DurationModel>> getDurations() async {
    const myPostsEndPoint = 'jobs/duration';
    
    final result = await apiservice.getData(Uri.parse('$BASE_URL/$myPostsEndPoint'));
    
    
    if(result.statusCode == 200)
    {
      final data = result.data;
    final dataJson = jsonDecode(data);
    List<DurationModel> durationModels = [];
    for (var duration in dataJson) {
      
      durationModels.add(DurationModel.fromJson(duration));
    }
    return durationModels;
    }
    else if(399<result.statusCode && result.statusCode < 500)
    {
      throw UnauthenticatedException();
    }
    else
    {
      throw ServerException();
    }
  }

  
}