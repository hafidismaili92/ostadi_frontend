import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ostadi_frontend/features/posts/data/models/post_model.dart';


void main() {
  String jsonString = '''{
    "id": 1,
    "student": {
      "id": 15,
      "user": {
        "id": 24,
        "name": "studentAccount"
      }
    },
    "duration": {
      "id": 1,
      "duration": "Less than 1 month"
    },
    "subjects": [
      {
        "title": "Physics"
      },
      {
        "title": "math"
      }
    ],
    "title": "test for post 1",
    "description": "this is a test for post description, this is a test for post description, this is a test for post description, this is a test for post description,",
    "amount": "800.00",
    "date": "2024-03-21T10:46:27.824977Z"
  }''';
  Map<String,dynamic> tjson = jsonDecode(jsonString);
  PostModel excpectedPostModel = PostModel(id: "1",description: "this is a test for post description, this is a test for post description, this is a test for post description, this is a test for post description,", title: "test for post 1", date: "2024-03-21T10:46:27.824977Z", proposalCount: 0, hiredCount: 0, duration: "Less than 1 month",durationId: '1',amount: 800, subjects: ["Physics","math"], postedBy: "studentAccount",postedById: "24");
  test('test create model from map success', () {
    // Act
    final result = PostModel.fromJson(tjson);
   
    //assert
    expect(result, excpectedPostModel);
  });

  test('test create model from map with duration null success', () {
    // Act
    tjson["duration"] = null;
    
    final result = PostModel.fromJson(tjson);
    final postmodelwithNullDuration = PostModel(id: "1",description: "this is a test for post description, this is a test for post description, this is a test for post description, this is a test for post description,", title: "test for post 1", date: "2024-03-21T10:46:27.824977Z", proposalCount: 0, hiredCount: 0, duration: "not indicated",durationId: '-1',amount: 800, subjects: ["Physics","math"], postedBy: "studentAccount",postedById: "24");
    //assert
    expect(result, postmodelwithNullDuration );
  });
}