

import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
 
  Future<Either<Failure,AuthenticatedUserEntity>> getAuthenticatedUser();
}