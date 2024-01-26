import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';

class StudentModel extends StudentEntity{
  StudentModel({required super.email, required super.token, required super.name});

  factory StudentModel.fromJson(Map<String,dynamic> jsonFormat)
  {
    return StudentModel(email:jsonFormat['email'],token: jsonFormat['token'],name: jsonFormat['name']  );
  }
}