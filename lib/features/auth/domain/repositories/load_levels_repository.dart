
import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/level_entity.dart';

abstract class LoadLevelsRepository {
Future<Either<Failure,List<Level>>> loadLevels();
}



