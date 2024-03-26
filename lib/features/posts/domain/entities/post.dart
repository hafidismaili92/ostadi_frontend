
import 'package:equatable/equatable.dart';

class Post extends Equatable {

  final String id;
  final String description;
  final String title;
  final String date;
  final int proposalCount;
  final int hiredCount;
  final String duration;
  final double amount;
  final List<String> subjects;
  final String postedBy;
  final String postedById;
  Post({required this.id,required this.description, required this.title, required this.date,required this.duration,required this.amount,required this.subjects, required this.proposalCount, required this.hiredCount,required this.postedBy,required this.postedById});
  
  @override
  // TODO: implement props
  List<Object?> get props => [id,title,description,date,proposalCount,hiredCount,duration,subjects,amount];

}