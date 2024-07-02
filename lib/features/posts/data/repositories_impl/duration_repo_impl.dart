

import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/duration_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/duration.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/duration_repository.dart';

class DurationRepositoryImpl implements DurationRepository{

  final DurationRemoteDataSource datasource;

  DurationRepositoryImpl({required this.datasource});
  
  @override
  Future<Either<Failure, List<DurationEntity>>> loadDurations() async {
    try {
  final result = await datasource.getDurations();
      return Right(result);
} on ServerException {
      return Left(ServerFailure());
    } on NoConnectionException {
      return Left(ConnectionFailure());
    } on Exception catch (e) {
      return Left(UnknownFailure());
    }
  }

}