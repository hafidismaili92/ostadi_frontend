

import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';

class AuthenticatedUserModel extends AuthenticatedUserEntity
{
  AuthenticatedUserModel({required super.isDefaultStudent, required super.isProfessor, required super.isStudent, required super.email, required super.avatar, required super.name});

  factory AuthenticatedUserModel.fromJson(Map<String, dynamic> jsonFormat) {
      return AuthenticatedUserModel(isDefaultStudent: jsonFormat['is_default_student'], isProfessor: jsonFormat['is_professor'], isStudent: jsonFormat['is_student'], email: jsonFormat['email'], avatar: jsonFormat['avatar'], name: jsonFormat['name']);
  }
  

}