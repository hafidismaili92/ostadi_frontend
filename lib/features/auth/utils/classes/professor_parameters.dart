import 'package:ostadi_frontend/features/auth/utils/classes/user_parameters.dart';

class  ProfessorParams extends UserParams {
  final List<String> subjects;
  ProfessorParams({required this.subjects,required super.email, required super.password,required super.name});

}