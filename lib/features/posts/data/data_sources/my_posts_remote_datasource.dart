

import 'dart:convert';

import 'package:ostadi_frontend/core/constants/api.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/posts/data/models/post_model.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';

class PostsRemoteDataSource {

final ApiService apiservice;

  PostsRemoteDataSource({required this.apiservice});


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

  Future<List<PostModel>> loadPosts(String token) async {
    const postsEndPoint = 'jobs/all-jobs';
    
    final result = await apiservice.getData(Uri.parse('$BASE_URL/$postsEndPoint'),{'Authorization':'Token $token'});
    
    
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

  Future<PostModel> addNewPost(PostParams postParams,String token) async {
    
    const addPostsEndPoint = 'jobs/my-jobPosts/';
    final result = await apiservice.postData(Uri.parse('$BASE_URL/$addPostsEndPoint'),postParams.toJson(),{'Authorization':'Token $token'});
    
    if(result.statusCode==201)
    {
      final postJson = jsonDecode(result.data);
      return PostModel.fromJson(postJson);
    }
    else
    {
      throw ServerException();
    }
    
  }

}