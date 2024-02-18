

import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/authentication_repository.dart';

class GetAuthenticatedUserUC 
{
  final AuthenticationRepository authRepository;

  GetAuthenticatedUserUC({required this.authRepository});
  
Future<Either<Failure,AuthenticatedUserEntity>> getAuthenticadedUser() async
{
  final res = await authRepository.getAuthenticatedUser();
  return res;
}
}