import 'dart:convert';
import 'dart:math';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/models/bloodPressureModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture.dart';

void main(){

  final bloodPressureResponseString = fixture("patientsMedical/medicalExamination/bloodPressureResponse.json");
  final bloodPressureNullDateResponseString = fixture("patientsMedical/medicalExamination/bloodPressureNullDateResponse.json");
  final bloodPressureWrongFormatDateResponseString = fixture("patientsMedical/medicalExamination/bloodPressureWrongFormatDateDateResponse.json");

  group("Testing from json", () {

    test("Should return correct format of complete response", () {
      final correctResponse = BloodPressureModel(
        when: "25-10-2019",
        readingInClinic:"140/98" ,
        lastReading:"118/57" ,
        drug:"Nifedipine" ,
        status:BloodPressureEnum.HypotensiveControlled ,
      );
      final result = BloodPressureModel.fromJson(json.decode(bloodPressureResponseString));
      expect(result,correctResponse);
    });

    test("Should handle null date", () {
      final correctResponse = BloodPressureModel(
        readingInClinic:"140/98" ,
        lastReading:"118/57" ,
        drug:"Nifedipine" ,
        status:BloodPressureEnum.HypotensiveControlled ,
      );
      final result = BloodPressureModel.fromJson(json.decode(bloodPressureNullDateResponseString));
      expect(result,correctResponse);
    });

    test(skip:true,"Should handle wrong format date", () {
      final correctResponse = BloodPressureModel(
        readingInClinic:"140/98" ,
        lastReading:"118/57" ,
        drug:"Nifedipine" ,
        status:BloodPressureEnum.HypotensiveControlled ,
      );
      final result = BloodPressureModel.fromJson(json.decode(bloodPressureWrongFormatDateResponseString));
      expect(result,correctResponse);
    });

  },);


  group("Testing to json", () {

    test("Should return correct format of complete response", () {
      final correctResponse = BloodPressureModel(
        when: "25-10-2019",
        readingInClinic:"140/98" ,
        lastReading:"118/57" ,
        drug:"Nifedipine" ,
        status:BloodPressureEnum.HypotensiveControlled ,
      );

      expect(correctResponse.toJson(),json.decode(bloodPressureResponseString));
    });

    test("Should handle null date", () {
      final correctResponse = BloodPressureModel(
        readingInClinic:"140/98" ,
        lastReading:"118/57" ,
        drug:"Nifedipine" ,
        status:BloodPressureEnum.HypotensiveControlled ,
      );
      expect(correctResponse.toJson(),json.decode(bloodPressureNullDateResponseString));
    });

    test(skip:true,"Should handle wrong format date", () {
      final correctResponse = BloodPressureModel(
        readingInClinic:"140/98" ,
        lastReading:"118/57" ,
        drug:"Nifedipine" ,
        status:BloodPressureEnum.HypotensiveControlled ,
      );
      final result = BloodPressureModel.fromJson(json.decode(bloodPressureWrongFormatDateResponseString));
      expect(result,correctResponse);
    });

  },);


}