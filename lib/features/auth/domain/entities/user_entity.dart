import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
final String avatar;
final String name;
final String email;

  const UserEntity({required this.email,required this.avatar,required this.name});
  
  @override
  List<Object?> get props => [avatar,name,email];

}

class AuthenticatedUserEntity extends UserEntity
{
final bool isStudent;
final bool isProfessor;
final bool isDefaultStudent;

  AuthenticatedUserEntity({required this.isDefaultStudent,required this.isProfessor,required this.isStudent,required super.email, required super.avatar, required super.name});
   @override
  List<Object?> get props => [avatar,name,email,isDefaultStudent,isStudent,isProfessor];
}

class StudentEntity extends UserEntity {
  String level;
  StudentEntity( {required this.level,required super.email,required super.avatar, required super.name});
   @override
  List<Object?> get props => [avatar,name,email,level];
}

class ProfEntity extends UserEntity {
  List<String> subjects;
  ProfEntity({required this.subjects,required super.email,required super.avatar,required super.name});
  @override
  List<Object?> get props => [avatar,name,email,subjects];
  
}


