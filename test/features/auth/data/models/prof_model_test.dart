import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ostadi_frontend/features/auth/data/models/prof_model.dart';
import 'package:ostadi_frontend/features/auth/data/models/student_model.dart';

void main() {
  String jsonString = '{"email":"test@example.com","avatar": "test avatar", "name": "test student", "subjects":["1";"2"]}';
  Map<String,dynamic> tjson = jsonDecode(jsonString);
  ProfModel expectedModel = ProfModel(email: 'test@example.com', avatar: 'test avatar', name: 'test student',subjects: ["1","2"]);
  test('should return a Prof Model from a json representing data of this model', (){
    // Act
    final result = ProfModel.fromJson(tjson);
    //assert
    expect(result, expectedModel);
  });

  test('should return a User Model from a json representing data of this model', (){
    // Act
    final result = StudentModel.fromJson(tjson);
    //assert
    expect(result, expectedModel);
  });
}