import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ostadi_frontend/features/auth/data/models/subject_model.dart';


void main() {
  String jsonString = '{"id":"1","title": "test subject", "icon": "test icon"}';
  Map<String,dynamic> tjson = jsonDecode(jsonString);
  SubjectModel expectedModel = SubjectModel(id: '1', title: 'test subject', icon: 'test icon');
  test('should return a subject Model from a json representing data of this model', (){
    // Act
    final result = SubjectModel.fromJson(tjson);
    //assert
    expect(result, expectedModel);
  });
}