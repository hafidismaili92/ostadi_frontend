import 'package:ostadi_frontend/features/auth/domain/entities/level_entity.dart';

class LevelModel extends Level {
  LevelModel({required super.id, required super.title,});

  factory LevelModel.fromJson(Map<String,dynamic> jsonFormat)
  {
    
    return LevelModel(id:'${jsonFormat['id']}',title: jsonFormat['title'],);
  }
}