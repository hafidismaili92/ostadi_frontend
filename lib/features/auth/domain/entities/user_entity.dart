import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable {
final String token;
final String avatar;
final String name;

  const UserEntity({required this.token, required this.avatar, required this.name});
  
  @override
  List<Object?> get props => [token,avatar,name];

}

class StudentEntity extends UserEntity {
  
  const StudentEntity({required super.token, required super.avatar, required super.name});

}

class ProfEntity extends UserEntity {
  
  const ProfEntity({required super.token, required super.avatar, required super.name});

}


