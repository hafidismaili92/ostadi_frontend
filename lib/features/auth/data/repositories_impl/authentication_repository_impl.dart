import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';

import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/authentication_repository.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {

final AuthRemoteDataSource remoteDS;
final TokenRepository tokenRepo;

  AuthenticationRepositoryImpl({required this.remoteDS,required this.tokenRepo});


  @override
  Future<Either<Failure, AuthenticatedUserEntity>> getAuthenticatedUser() async{
    try {
      final token = await tokenRepo.readToken();
      
    if(token != null)
    {
      final res = await remoteDS.getAuthenticatedUser(token);
      
      return Right(res);
    }
    return Left(NoTokenRegistredFailure());
    } on UnauthenticatedException {
      return Left(UnauthenticatedFailure());
    }
    on ServerException
    {
      return Left(ServerFailure());
    }
    catch (e)
    {
      
      return Left(UnknownFailure());
    }
    
  }
}