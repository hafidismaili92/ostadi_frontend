import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/register_user_repository.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

class RegisterStudentUseCase {
  final RegisterUserRepo repository;

  RegisterStudentUseCase({required this.repository});

  Future<Either<Failure,StudentEntity>> registerNewStudent(StudentParams studentParams) async
  {
    final result = await repository.registerNewStudent(studentParams);

    return result;
  }
}