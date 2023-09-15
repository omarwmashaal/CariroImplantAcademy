import 'dart:convert';
import 'dart:math';

import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/biteModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/diagnosticImpressionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture.dart';

void main() {
  final tProstheticJson = json.decode(fixture("patientsMedical/prosthetic/diagnostic.json"));
  final tProstheticModel = ProstheticTreatmentModel(
    id: 1,
    prostheticDiagnostic_DiagnosticImpression: [
      DiagnosticImpressionModel(
          diagnostic: EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[0],
          nextStep: EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[0],
          id: 1,
          prostheticTreatmentId: 2,
          //   prostheticTreatment: null,
          patientId: 1,
          patient: null,
          date: DateTime.tryParse("2023-06-13T18:15:16.406086Z"),
          operatorId: 101,
          operator: BasicNameIdObjectModel(),
          needsRemake: false),
      DiagnosticImpressionModel(
          diagnostic: EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[0],
          nextStep: EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[2],
          id: 2,
          prostheticTreatmentId: 2,
          //  prostheticTreatment: null,
          patientId: 1,
          patient: null,
          date: DateTime.tryParse("2023-06-13T18:15:16.517195Z"),
          operatorId: 101,
          operator: BasicNameIdObjectModel(),
          needsRemake: false),
      DiagnosticImpressionModel(
          diagnostic: EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[0],
          nextStep: EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[3],
          id: 3,
          prostheticTreatmentId: 2,
          //  prostheticTreatment: null,
          patientId: 1,
          patient: null,
          date: DateTime.tryParse("2023-06-13T18:18:35.480885Z"),
          operatorId: 101,
          operator: BasicNameIdObjectModel(),
          needsRemake: true)
    ],
    prostheticDiagnostic_Bite: [
      BiteModel(
          diagnostic: EnumProstheticDiagnosticBiteDiagnostic.values[0],
          nextStep: null,
          id: 4,
          prostheticTreatmentId: 2,
          // prostheticTreatment: null,
          patientId: 1,
          patient: null,
          date: DateTime.tryParse("2023-08-28T18:23:29.172091Z"),
          operatorId: 107,
          operator: BasicNameIdObjectModel(),
          needsRemake: false),
    ],
    prostheticDiagnostic_ScanAppliance: [],
  );

  test("Should return correct format from json", ()=>expect(ProstheticTreatmentModel.fromJson(tProstheticJson),tProstheticModel));
}
