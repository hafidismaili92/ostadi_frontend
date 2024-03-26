import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({required super.id,required super.description, required super.title, required super.date, required super.proposalCount, required super.hiredCount, required super.duration, required super.amount, required super.subjects, required super.postedBy, required super.postedById});


  factory PostModel.fromJson(Map<String,dynamic> postString)
  {
    return PostModel(id: postString['id'].toString(), title: postString['title'],description:postString['description'],date: postString['date'], proposalCount: 0, hiredCount: 0, duration: postString['duration']['duration'],amount: double.parse(postString['amount']),subjects: postString['subjects'].map((subject)=>subject['title']).toList().cast<String>(), postedBy: postString['student']['user']['name'],postedById: postString['student']['id'].toString());
  }

}