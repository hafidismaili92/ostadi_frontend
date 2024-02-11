import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/subject_entity.dart';

abstract class LoadSubjectsRepository {

  Future<Either<Failure,List<Subject>>> loadSubjects();
}

