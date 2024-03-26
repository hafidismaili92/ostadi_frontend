

import 'dart:convert';

import 'package:ostadi_frontend/core/constants/api.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/posts/data/models/post_model.dart';

class MyPostsRemoteDataSource {

final ApiService apiservice;

  MyPostsRemoteDataSource({required this.apiservice});


  Future<List<PostModel>> loadMyPosts(String token) async {
    const myPostsEndPoint = 'jobs/my-jobPosts/';
    
    final result = await apiservice.getData(Uri.parse('$BASE_URL/$myPostsEndPoint'),{'Authorization':'Token $token'});
    
    if(result.statusCode == 200)
    {
      final data = result.data;
    final dataJson = jsonDecode(data);
    List<PostModel> postModels = [];
    for (var post in dataJson) {
      postModels.add(PostModel.fromJson(post));
    }
    return postModels;
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