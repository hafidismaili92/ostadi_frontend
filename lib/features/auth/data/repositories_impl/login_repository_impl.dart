import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/core/platform/connectionInfo.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/login_repository.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenRepository tokenRepository;
  final Connectioninfo connectionInfo;
  LoginRepositoryImplementation(
      {required this.connectionInfo,
      required this.remoteDataSource,
      required this.tokenRepository});
  @override
  Future<Either<Failure, String>> getAndStoreToken(Loginparams params) async {
    final isConnected = await connectionInfo.isConnected;
    if (isConnected) {
      try {
        final res = await remoteDataSource.getToken(params);
        await tokenRepository.storeToken(res);
        return Right(res);
      } on UnauthenticatedException {
        return Left(UnauthenticatedFailure());
      } on ServerException {
        return Left(ServerFailure());
      } on Exception catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
