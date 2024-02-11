
import 'package:equatable/equatable.dart';

class Level extends Equatable{
  final int id;
  final String title;

  Level({required this.id, required this.title});
  @override
  
  List<Object?> get props => [id,title];

}