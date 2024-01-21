import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';

class RegisterProfUseCase {
  final RegisterUserRepo repository;

  RegisterProfUseCase({required this.repository});

  Future<Either<Failure,ProfEntity>> registerNewProf(ProfessorParams profParams) async
  {
    final result = await repository.registerNewProfessor(profParams);

    return result;
  }
}