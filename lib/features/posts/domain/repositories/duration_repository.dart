// TODO Implement this library.


import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/duration.dart';

abstract class DurationRepository {

  Future<Either<Failure,List<DurationEntity>>> loadDurations();
  
}