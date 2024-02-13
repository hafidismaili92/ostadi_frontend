import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:ostadi_frontend/core/constants/api.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/auth/data/models/level_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/prof_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/student_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/subject_model.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

abstract class AuthRemoteDataSource {
  Future<ProfModel> registerProf(ProfessorParams params);
  Future<StudentModel> registerStudent(StudentParams params);
  Future<List<SubjectModel>> loadSubjects();

   Future<List<LevelModel>> loadLevels();
}



class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource{
  final ApiService apiservice;
  static const String levelsEndPoint = 'profils/levels/';
  static const String subjectsEndPoint = 'profils/subjects/';
  static const String createUserEndPoint ='user/create/';
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

}


