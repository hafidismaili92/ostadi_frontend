import 'package:ostadi_frontend/features/auth/domain/entities/subject_entity.dart';

class SubjectModel extends Subject {
  SubjectModel({required super.id, required super.title, required super.icon});

  factory SubjectModel.fromJson(Map<String,dynamic> jsonFormat)
  {
    
    return SubjectModel(id:'${jsonFormat['id']}',title: jsonFormat['title'],icon: jsonFormat['icon']  );
  }
}