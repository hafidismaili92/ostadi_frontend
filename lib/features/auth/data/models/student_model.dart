import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';

class StudentModel extends StudentEntity{
  StudentModel({required super.level,required super.email, required super.avatar, required super.name});

  factory StudentModel.fromJson(Map<String,dynamic> jsonFormat)
  {
    return StudentModel(email:jsonFormat['email'],level:jsonFormat['student_account'] != null ?jsonFormat['student_account']['level']??'':'',avatar: jsonFormat['avatar']??'',name: jsonFormat['name']??'');
  }
}