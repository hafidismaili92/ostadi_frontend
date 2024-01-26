import 'package:ostadi_frontend/features/auth/data/models/prof_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/student_model.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

abstract class RemoteDataSource {
  Future<ProfModel> registerProf(ProfessorParams params);
  Future<StudentModel> registerStudent(StudentParams params);
}

class RemoteDataSourceImplementation implements RemoteDataSource{
  @override
  Future<ProfModel> registerProf(ProfessorParams params) {
    // TODO: implement registerProf
    throw UnimplementedError();
  }

  @override
  Future<StudentModel> registerStudent(StudentParams params) {
    // TODO: implement registerStudent
    throw UnimplementedError();
  }

}


