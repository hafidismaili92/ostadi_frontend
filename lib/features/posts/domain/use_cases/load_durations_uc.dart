
import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/duration.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/duration_repository.dart';

class LoadDurations
  
{
  final DurationRepository repository;

  LoadDurations({required this.repository});
  
  Future<Either<Failure,List<DurationEntity>>> execute() async {

      final result = await repository.loadDurations();
      return result;
  }
}