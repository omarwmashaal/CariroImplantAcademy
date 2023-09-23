import 'dart:convert';
import 'dart:math';

import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/data/authentication/models/AuthenticationUserModel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture.dart';

void main() {
  setUp(() {});
  final tJson = json.decode(fixture("authentication/loginResponse.json"));
  final tUserModel = AuthenticationUserModel(
    phoneNumber: "string",
    name: "string",
    idInt: 0,
    role: "string",
    token: "this is my token string",
    phone: "string",
  );
  test(
    "Should return correct UserModel from json",
    () {
      final result = AuthenticationUserModel.fromJson(tJson);
      expect(result, tUserModel);
    },
  );
}
