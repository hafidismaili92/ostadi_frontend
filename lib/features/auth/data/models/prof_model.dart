

import 'package:ostadi_frontend/features/auth/data/models/authenticated_user_model.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';



class ProfModel extends ProfEntity {
  ProfModel({required super.subjects,required super.email, required super.avatar, required super.name});

  factory ProfModel.fromJson(Map<String, dynamic> jsonFormat) {
    return ProfModel(subjects: jsonFormat['professor_account'] != null ?jsonFormat['professor_account']['subjects']??[]:[],email:jsonFormat['email'],avatar: jsonFormat['avatar']??'',name: jsonFormat['name']??'');
  }
}