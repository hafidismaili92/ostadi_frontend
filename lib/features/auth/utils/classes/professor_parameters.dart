import 'package:ostadi_frontend/features/auth/utils/classes/user_parameters.dart';

class  ProfessorParams extends UserParams {
  final List<String> subjects;
  ProfessorParams({required this.subjects,required super.email, required super.password,required super.name});

 Map<String,dynamic> toJson ()
  {
    return {
      "email":email,
      "name":name,
      "password":password,
      "professor_account":{
        "subjects_ids":subjects
      }
    };
  }
}