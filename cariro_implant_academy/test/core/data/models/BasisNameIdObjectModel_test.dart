import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  final tJson = {
    "name":"name",
    "id":0
  };
  test("Should return correct format of BasicNameIdModel from json", () {
    final result = BasicNameIdObjectModel.fromJson(tJson);
    expect(result,BasicNameIdObjectModel(name: "name", id: 0));
  });
}