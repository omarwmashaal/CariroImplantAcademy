import 'dart:convert';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/data/models/dentalExaminationBaseModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/data/models/dentalExaminationModel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture.dart';

void main() {
  final tResponseJson = json.decode(fixture("patientsMedical/dentalExamination/dentalExaminationResponse.json"));
  final tResponseModel = DentalExaminationBaseModel(
    id: 3,
    patientId: 3,
    interarchSpaceRT: 0,
    interarchSpaceLT: 0,
    oralHygieneRating: EnumOralHygieneRating.GoodHygiene,
    date: DateTime.parse("2023-06-13T16:22:13.630006Z"),
    operatorImplantNotes: "",
    operatorId: null,
    operator: BasicNameIdObjectModel(
  name: "Admin",
  id: 101
  ),
    dentalExaminations: [
      DentalExaminationModel(
        tooth: 15,
        carious: false,
        filled: true,
        missed: false,
        notSure: false,
        mobilityI: false,
        mobilityII: false,
        mobilityIII: false,
        hopelessTeeth: false,
        implantPlaced: false,
        implantFailed: false,
        previousState: "missed",
      ),
    ],
  );

  test("Testing from json", () => expect(DentalExaminationBaseModel.fromMap(tResponseJson), tResponseModel));
  test("Testing to json", () => expect(tResponseModel.toMap(), (tResponseJson as Map<String,dynamic>)..remove('operator')));
}
