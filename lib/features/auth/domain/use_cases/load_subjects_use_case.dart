
import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/subject_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_subjects_repository.dart';

class LoadSubjectsUseCase {
  final LoadSubjectsRepository repository;

  LoadSubjectsUseCase({required this.repository});
  
  Future<Either<Failure,List<Subject>>> loadSubjects() async {
      final result = await repository.loadSubjects();
      return result;
  }


}