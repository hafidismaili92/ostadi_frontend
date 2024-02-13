import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/data_sources/remote_dataSource.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

class RegisterUserRepoImpl implements RegisterUserRepo{
  final AuthRemoteDataSource remoteDataSource;

  RegisterUserRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, ProfEntity>> registerNewProfessor(ProfessorParams profParams) async {
    
   try
   {
    final result = await remoteDataSource.registerProf(profParams);
   return Right(result);
   }
   on ServerException {
    return Left(ServerFailure());
   }
   catch(e)
   {
      return Left(UnknownFailure());
   }
  }

  @override
  Future<Either<Failure, StudentEntity>> registerNewStudent(StudentParams studentParams) async {
   
    try
   {
    final result = await remoteDataSource.registerStudent(studentParams);
   return Right(result);
   }
   on ServerException {
    return Left(ServerFailure());
   }
   catch(e)
   {
      return Left(UnknownFailure());
   }
  }

}