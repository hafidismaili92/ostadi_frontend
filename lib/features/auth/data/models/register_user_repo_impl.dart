import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

class RegisterUserRepoImpl implements RegisterUserRepo {
  @override
  Future<Either<Failure, ProfEntity>> registerNewProfessor(ProfessorParams profParams) {
    // TODO: implement registerNewProfessor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, StudentEntity>> registerNewStudent(StudentParams params) {
    // TODO: implement registerNewStudent
    throw UnimplementedError();
  }

}