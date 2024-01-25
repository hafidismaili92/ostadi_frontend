import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable {
final String token;
final String name;
final String email;
  const UserEntity({required this.email,required this.token,required this.name});
  
  @override
  List<Object?> get props => [token,name,email];

}

class StudentEntity extends UserEntity {
  
  const StudentEntity( {required super.email,required super.token, required super.name});

}

class ProfEntity extends UserEntity {
  
  const ProfEntity({required super.email,required super.token,required super.name});

}


