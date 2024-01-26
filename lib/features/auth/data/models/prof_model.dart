

import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';

class ProfModel extends ProfEntity {
  ProfModel({required super.email, required super.token, required super.name});

  factory ProfModel.fromJson(Map<String, dynamic> jsonFormat) {
    return ProfModel(email:jsonFormat['email'],token: jsonFormat['token'],name: jsonFormat['name']  );
  }
}