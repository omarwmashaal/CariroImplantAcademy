import 'dart:convert';

import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/models/bloodPressureModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/models/diabeticModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/models/hba1cModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/models/medicalExaminationModel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture.dart';

void main() {
  var tMedicalExaminationResponse = json.decode(fixture("patientsMedical/medicalExamination/medicalExaminationResponse.json"));
  var tMedicalExaminationResponse2 = json.decode(fixture("patientsMedical/medicalExamination/medicalExaminationResponse2.json"));
  var tMedicalExaminationModel = MedicalExaminationModel(
    id: 4,
    patientId: 4,
    generalHealth: GeneralHealthEnum.Good,
    pregnancyStatus: PregnancyEnum.Lactating,
    areYouTreatedFromAnyThing: null,
    recentSurgery: null,
    comment: null,
    diseases: [
      DiseasesEnum.VenerealDisease,
      DiseasesEnum.Other,
    ],
    otherDiseases: null,
    bloodPressure: BloodPressureModel(
      lastReading: "118/57",
      when: "25-10-2019",
      drug: "Nifedipine",
      readingInClinic: "140/98",
      status: BloodPressureEnum.HypotensiveControlled,
    ),
    diabetic: DiabeticModel(
      lastReading: 173,
      when: "21-10-2020",
      randomInClinic: 95,
      status: DiabetesEnum.Normal,
      type: DiabetesMeasureType.Random,
    ),
    hbA1c: [
      HBA1CModel(date: "11-10-1979", reading: 6),
      HBA1CModel(date: "24-04-1998", reading: 6),
      HBA1CModel(date: "17-08-1982", reading: 6),
    ],
    penicillin: false,
    sulfa: null,
    otherAllergy: null,
    otherAllergyComment: null,
    prolongedBleedingOrAspirin: null,
    chronicDigestion: null,
    illegalDrugs: "Yes",
    operatorComments: null,
    drugsTaken: null,
    operatorId: null,
    operator: null,
    date: null,
  );
  var tMedicalExaminationModel2 = MedicalExaminationModel(
    id: 583,
    patientId: 562,
    generalHealth: GeneralHealthEnum.Good,
    pregnancyStatus: null,
    areYouTreatedFromAnyThing: null,
    recentSurgery: null,
    comment: null,
    diseases: null,
    otherDiseases: null,
    bloodPressure: null,
    diabetic: null,
    hbA1c: [
      HBA1CModel(date: null, reading: 0),
    ],
    penicillin: null,
    sulfa: null,
    otherAllergy: null,
    otherAllergyComment: null,
    prolongedBleedingOrAspirin: null,
    chronicDigestion: null,
    illegalDrugs: null,
    operatorComments: null,
    drugsTaken:<String> [],
    operatorId: null,
    operator: BasicNameIdObjectModel(
      id: 101,
      name: "Admin",
    ),
    date: "2023 - 07 - 23T15:43: 35.80004Z",
  );

  group(
    "Testing from json",
    () {
      test(
        "Should return correct format",
        () {
          expect(MedicalExaminationModel.fromJson(tMedicalExaminationResponse), tMedicalExaminationModel);
        },
      );
      test(
        "Should return correct format from response 2",
        () {
          expect(MedicalExaminationModel.fromJson(tMedicalExaminationResponse2), tMedicalExaminationModel2);
        },
      );
    },
  );
  group(
    "Testing to json",
    () {
      test(
        "Should return correct format",
        () {
          (tMedicalExaminationResponse as Map<String, dynamic>).remove("operatorId");
          (tMedicalExaminationResponse as Map<String, dynamic>).remove("operator");
          (tMedicalExaminationResponse as Map<String, dynamic>).remove("date");
          (tMedicalExaminationResponse as Map<String, dynamic>).remove("hasChanges");
          expect(tMedicalExaminationModel.toJson(), tMedicalExaminationResponse);
        },
      );
    },
  );
}
