import 'package:equatable/equatable.dart';

class DurationEntity extends Equatable
{
  final String id;
  final String title;

  DurationEntity({required this.id, required this.title});
  
  @override
  // TODO: implement props
  List<Object?> get props => [id,title];
}