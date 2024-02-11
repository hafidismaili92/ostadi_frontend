import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/core/platform/connectionInfo.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/subject_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_subjects_repository.dart';

class LoadSubjectsRepoImpl implements LoadSubjectsRepository {
  final AuthRemoteDataSource remoteDataSource;
  final Connectioninfo connectionInfo;
  LoadSubjectsRepoImpl(
      {required this.remoteDataSource, required this.connectionInfo});

  @override
  Future<Either<Failure, List<Subject>>> loadSubjects() async {
    final isConnected = await connectionInfo.isConnected;
    if (isConnected) {
      try {
        final res = await remoteDataSource.loadSubjects();
        return Right(res);
      } on ServerException {
        return Left(ServerFailure());
      }
      catch (e){
        return Left(UnknownFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
