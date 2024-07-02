import 'package:ostadi_frontend/features/posts/domain/entities/duration.dart';

class DurationModel extends DurationEntity {
  DurationModel({required super.id, required super.title});

  factory DurationModel.fromJson(Map<String,dynamic> durationJson)
  {
    return DurationModel(id: durationJson['id'].toString(), title: durationJson['duration']);
  }
}