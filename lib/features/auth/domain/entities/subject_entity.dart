import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  final int id;
  final String title;
  final String icon;

  Subject({required this.id, required this.title, required this.icon});
  
  @override

  List<Object?> get props => [id,title,icon];

}