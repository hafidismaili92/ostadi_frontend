import 'package:equatable/equatable.dart';

class Proposal extends Equatable {
  final String id;
  final String postId;
  final String description;
  final double amount;
  final String date;
  Proposal({required this.id,required this.postId, required this.description, required this.amount,required this.date});
  
  @override
  // TODO: implement props
  List<Object?> get props => [postId,description,amount,date];
}