
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/features/posts/data/models/post_model.dart';

class Post extends Equatable {

  final String id;
  final String description;
  final String title;
  final String date;
  final int proposalCount;
  final int hiredCount;
  final String duration;
  final String durationId;
  final double amount;
  final List<String> subjects;
  final String postedBy;
  final String postedById;
  Post({required this.id,required this.description, required this.title, required this.date,required this.duration,required this.durationId,required this.amount,required this.subjects, required this.proposalCount, required this.hiredCount,required this.postedBy,required this.postedById});
  
  @override
  
  List<Object?> get props => [id,title,description,date,proposalCount,hiredCount,duration,subjects,amount,durationId];

  Post copyWith({
    String? id,
    String? description,
    String? title,
    String? date,
    int? proposalCount,
    int? hiredCount,
    String? duration,
    String? durationId,
    double? amount,
    List<String>? subjects,
    String? postedBy,
    String? postedById,
  }) {
    return Post(
      id: id ?? this.id,
      description: description ?? this.description,
      title: title ?? this.title,
      date: date ?? this.date,
      proposalCount: proposalCount ?? this.proposalCount,
      hiredCount: hiredCount ?? this.hiredCount,
      duration: duration ?? this.duration,
      durationId: durationId ?? this.durationId,
      amount: amount ?? this.amount,
      subjects: subjects ?? this.subjects,
      postedBy: postedBy ?? this.postedBy,
      postedById: postedById ?? this.postedById,
    );
  }

}