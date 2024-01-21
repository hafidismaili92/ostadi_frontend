import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

abstract class RegisterUserRepo {
Future<Either<Failure,StudentEntity>> registerNewStudent(StudentParams params);

Future<Either<Failure,ProfEntity>> registerNewProfessor(ProfessorParams profParams);
}

