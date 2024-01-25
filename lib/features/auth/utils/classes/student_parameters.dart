import 'package:ostadi_frontend/features/auth/utils/classes/user_parameters.dart';

class  StudentParams extends UserParams {
  final String level;
  StudentParams({required this.level,required super.email, required super.password,required super.name});

}