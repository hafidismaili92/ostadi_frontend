import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:ostadi_frontend/core/constants/api.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/models/level_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/prof_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/student_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/subject_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/authenticated_user_model.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

abstract class AuthRemoteDataSource {
  Future<ProfModel> registerProf(ProfessorParams params);
  Future<StudentModel> registerStudent(StudentParams params);
  Future<List<SubjectModel>> loadSubjects();
  Future<String> getToken(Loginparams params);
  Future<List<LevelModel>> loadLevels();

  Future<AuthenticatedUserModel> getAuthenticatedUser(String token);
}



class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource{
  final ApiService apiservice;
  static const String levelsEndPoint = 'profils/levels/';
  static const String subjectsEndPoint = 'profils/subjects/';
  static const String createUserEndPoint ='user/create/';
  static const String getTokenEndPoint = 'user/token-auth/';
  static const String getAuthenticatedUserEndPoint = 'user/authenticate-user';
  AuthRemoteDataSourceImplementation({required this.apiservice});
  @override
  Future<ProfModel> registerProf(ProfessorParams params) async{
    final res = await apiservice.postData(Uri.parse('$BASE_URL/$createUserEndPoint'),params.toJson());
    print(res.data);
    if(res.statusCode==201)
    {
      return ProfModel.fromJson(jsonDecode(res.data));
    }
    else
   {
    throw ServerException();
   }
  }

  @override
  Future<StudentModel> registerStudent(StudentParams params) async {
    
    final res = await apiservice.postData(Uri.parse('$BASE_URL/$createUserEndPoint'),params.toJson());
  
    if(res.statusCode==201)
    {
      return StudentModel.fromJson(jsonDecode(res.data));
    }
    else
   {
    throw ServerException();
   }
  }
  
  @override
  Future<List<SubjectModel>> loadSubjects() async{
   
   final res = await apiservice.getData(Uri.parse('$BASE_URL/$subjectsEndPoint'));
   if(res.statusCode==200)
   {
    final data = res.data;
    final dataJson = jsonDecode(data);
    List<SubjectModel> subjectsModels = [];
    for (var subject in dataJson) {
      subjectsModels.add(SubjectModel.fromJson(subject));
    }
    return subjectsModels;
   }
   else
   {
    throw ServerException();
   }

  }
  
  @override
  Future<List<LevelModel>> loadLevels() async{
    
   final res = await apiservice.getData(Uri.parse('$BASE_URL/$levelsEndPoint'));
   if(res.statusCode==200)
   {
    final data = res.data;
    final dataJson = jsonDecode(data);
    List<LevelModel> levelModels = [];
    for (var subject in dataJson) {
      levelModels.add(LevelModel.fromJson(subject));
    }
    return levelModels;
   }
   else
   {
    throw ServerException();
   }
  }
  
  @override
  Future<String> getToken(Loginparams params) async {
   
  
  final res = await apiservice.postData(Uri.parse('$BASE_URL/$getTokenEndPoint'),params.toJson());
  if(res.statusCode==200)
  {
    final data = jsonDecode(res.data);
    return data['token'];
  }
  else if([400,401].contains(res.statusCode))
  {
    throw UnauthenticatedException();
  }
  else
  {
    throw ServerException();
  }
  


  }
  
  @override
  Future<AuthenticatedUserModel> getAuthenticatedUser(String token) async {
    final res = await apiservice.getData(Uri.parse('$BASE_URL/$getAuthenticatedUserEndPoint'),{'Authorization':'Token $token'});
    final data = res.data;
    
    if(res.statusCode==200)
    {
      final userModel = AuthenticatedUserModel.fromJson(jsonDecode(data));
      
      return userModel;
    }
    else if(399<res.statusCode && res.statusCode < 500)
    {
      throw UnauthenticatedException();
    }
    else
    {
      throw ServerException();
    }
    
  }

}


