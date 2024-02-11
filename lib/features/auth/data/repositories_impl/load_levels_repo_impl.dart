import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/core/platform/connectionInfo.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/level_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_levels_repository.dart';

class LoadLevelsRepoImpl implements LoadLevelsRepository {
  final AuthRemoteDataSource remoteDataSource;
  final Connectioninfo connectionInfo;
  LoadLevelsRepoImpl(
      {required this.remoteDataSource, required this.connectionInfo});
  @override
  Future<Either<Failure, List<Level>>> loadLevels() async {
     final isConnected = await connectionInfo.isConnected;
    if (isConnected) {
    try {
      final res = await remoteDataSource.loadLevels();
      return Right(res);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
    }
    else
    {
      return Left(ConnectionFailure());
    }

  }
}
