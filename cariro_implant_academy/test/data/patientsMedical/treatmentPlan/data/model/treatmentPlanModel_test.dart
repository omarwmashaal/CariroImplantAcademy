import 'dart:convert';

import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/teethTreatmentPlanModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentPlanModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentPlanPropertyModel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture.dart';

void main() {
  final tResultModel = TreatmentPlanModel(
    id: 515,
    patientId: 1,
    operatorId: 101,
    operator: null,
    date: DateTime.parse("2023-08-26T19:23:56.032885Z"),
    treatmentPlan: [
      TeethTreatmentPlanModel(
          id: 2158,
          patientId: 1,
          patient: null,
          tooth: 16,
          scaling: null,
          crown: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: null,

              assignedTo: null,
              date: DateTime.parse("2021-05-01T21:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          rootCanalTreatment: null,
          restoration: null,
          pontic: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: 3,


              assignedTo: null,
              date: DateTime.parse("2015-05-20T21:00:00Z"),
              doneByAssistantID: 42,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          extraction: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2016-06-02T21:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          simpleImplant: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2018-11-17T22:00:00Z"),
              doneByAssistantID: 79,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          immediateImplant: null,
          expansionWithImplant: null,
          splittingWithImplant: null,
          gbrWithImplant: null,
          openSinusWithImplant: null,
          closedSinusWithImplant: null,
          guidedImplant: null,
          expansionWithoutImplant: null,
          splittingWithoutImplant: null,
          gbrWithoutImplant: null,
          openSinusWithoutImplant: null,
          closedSinusWithoutImplant: null),
      TeethTreatmentPlanModel(
          id: 2156,
          patientId: 1,
          patient: null,
          tooth: 17,
          scaling: null,
          crown: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2022-03-15T21:00:00Z"),
              doneByAssistantID: 42,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          rootCanalTreatment: null,
          restoration: null,
          pontic: null,
          extraction: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: 96,


              assignedTo: BasicNameIdObjectModel(
                id: 96,
                name: "Elsawy Khattab",
              ),
              date: DateTime.parse("2020-08-01T21:00:00Z"),
              doneByAssistantID: 98,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          simpleImplant: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2021-12-31T22:00:00Z"),
              doneByAssistantID: 89,
              doneByAssistant: null,
              doneBySupervisorID: 14,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          immediateImplant: null,
          expansionWithImplant: null,
          splittingWithImplant: null,
          gbrWithImplant: null,
          openSinusWithImplant: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2021-01-09T22:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          closedSinusWithImplant: null,
          guidedImplant: null,
          expansionWithoutImplant: null,
          splittingWithoutImplant: null,
          gbrWithoutImplant: null,
          openSinusWithoutImplant: null,
          closedSinusWithoutImplant: null),
      TeethTreatmentPlanModel(
          id: 2157,
          patientId: 1,
          patient: null,
          tooth: 21,
          scaling: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2017-11-21T22:00:00Z"),
              doneByAssistantID: 73,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          crown: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2022-08-12T21:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          rootCanalTreatment: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: 91,


              assignedTo: BasicNameIdObjectModel(
                id: 91,
                name: "Zaki Mokhtar",
              ),
              date: DateTime.parse("2019-11-25T22:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          restoration: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: 45,


              assignedTo: BasicNameIdObjectModel(
                id: 45,
                name: "Saied Ezz",
              ),
              date: DateTime.parse("2019-07-19T21:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          pontic: null,
          extraction: null,
          simpleImplant: null,
          immediateImplant: null,
          expansionWithImplant: null,
          splittingWithImplant: null,
          gbrWithImplant: null,
          openSinusWithImplant: null,
          closedSinusWithImplant: null,
          guidedImplant: null,
          expansionWithoutImplant: null,
          splittingWithoutImplant: null,
          gbrWithoutImplant: null,
          openSinusWithoutImplant: null,
          closedSinusWithoutImplant: null),
      TeethTreatmentPlanModel(
          id: 2154,
          patientId: 1,
          patient: null,
          tooth: 34,
          scaling: null,
          crown: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2015-08-17T21:00:00Z"),
              doneByAssistantID: 89,
              doneByAssistant: null,
              doneBySupervisorID: 28,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          rootCanalTreatment: null,
          restoration: null,
          pontic: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2022-12-04T21:00:00Z"),
              doneByAssistantID: 98,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: 88,
              doneByCandidate: null,
              doneByCandidateBatchID: 7,
              doneByCandidateBatch: null),
          extraction: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: 98,


              assignedTo: BasicNameIdObjectModel(
                id: 98,
                name: "Shehata Naser",
              ),
              date: DateTime.parse("2018-10-25T22:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          simpleImplant: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: null,


              assignedTo: null,
              date: DateTime.parse("2019-01-21T22:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          immediateImplant: null,
          expansionWithImplant: null,
          splittingWithImplant: null,
          gbrWithImplant: null,
          openSinusWithImplant: null,
          closedSinusWithImplant: null,
          guidedImplant: null,
          expansionWithoutImplant: null,
          splittingWithoutImplant: null,
          gbrWithoutImplant: null,
          openSinusWithoutImplant: null,
          closedSinusWithoutImplant: null),
      TeethTreatmentPlanModel(
          id: 2155,
          patientId: 1,
          patient: null,
          tooth: 45,
          scaling: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: 93,


              assignedTo: BasicNameIdObjectModel(
                id: 93,
                name: "Naser Shaban",
              ),
              date: DateTime.parse("2017-06-14T21:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          crown: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: 57,


              assignedTo: BasicNameIdObjectModel(
                id: 57,
                name: "Mido Yasser",
              ),
              date: DateTime.parse("2022-04-01T21:00:00Z"),
              doneByAssistantID: 73,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          rootCanalTreatment: null,
          restoration: null,
          pontic: TreatmentPlanPropertyModel(
              value: "",
              status: false,
              assignedToID: 3,


              assignedTo: null,
              date: DateTime.parse("2017-04-13T21:00:00Z"),
              doneByAssistantID: null,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          extraction: null,
          simpleImplant: null,
          immediateImplant: null,
          expansionWithImplant: null,
          splittingWithImplant: TreatmentPlanPropertyModel(
              value: "",
              status: true,
              assignedToID: 100,


              assignedTo: null,
              date: DateTime.parse("2015-08-13T21:00:00Z"),
              doneByAssistantID: 89,
              doneByAssistant: null,
              doneBySupervisorID: null,
              doneBySupervisor: null,
              doneByCandidateID: null,
              doneByCandidate: null,
              doneByCandidateBatchID: null,
              doneByCandidateBatch: null),
          gbrWithImplant: null,
          openSinusWithImplant: null,
          closedSinusWithImplant: null,
          guidedImplant: null,
          expansionWithoutImplant: null,
          splittingWithoutImplant: null,
          gbrWithoutImplant: null,
          openSinusWithoutImplant: null,
          closedSinusWithoutImplant: null)
    ],
  );
  final tAllJson = json.decode(fixture("patientsMedical/treatmentPlan/treatmentPlan.json"));

  group("Testing treatment Plan Property", () {
    test(
      "from json 1",
      () {
        expect(TreatmentPlanPropertyModel.fromJson((tAllJson["treatmentPlan"] as List<dynamic>)[0]['crown']), tResultModel.treatmentPlan![0].crown);
        expect(TreatmentPlanPropertyModel.fromJson((tAllJson["treatmentPlan"] as List<dynamic>)[0]['pontic']), tResultModel.treatmentPlan![0].pontic);
        expect(TreatmentPlanPropertyModel.fromJson((tAllJson["treatmentPlan"] as List<dynamic>)[0]['extraction']), tResultModel.treatmentPlan![0].extraction);
        expect(TreatmentPlanPropertyModel.fromJson((tAllJson["treatmentPlan"] as List<dynamic>)[0]['simpleImplant']),
            tResultModel.treatmentPlan![0].simpleImplant);
      },
    );
    test(
      "to json 1",
      () {
        expect(TreatmentPlanPropertyModel.fromEntity(tResultModel.treatmentPlan![0].crown!).toJson()..removeWhere((key, value) => value==null),
            ((tAllJson["treatmentPlan"] as List<dynamic>)[0]['crown'] as Map<String, dynamic>)..removeWhere((key, value) => value == null));
        expect(TreatmentPlanPropertyModel.fromEntity(tResultModel.treatmentPlan![0].pontic!).toJson()..removeWhere((key, value) => value==null),
            ((tAllJson["treatmentPlan"] as List<dynamic>)[0]['pontic'] as Map<String, dynamic>)..removeWhere((key, value) => value == null));
        expect(TreatmentPlanPropertyModel.fromEntity(tResultModel.treatmentPlan![0].extraction!).toJson()..removeWhere((key, value) => value==null),
            ((tAllJson["treatmentPlan"] as List<dynamic>)[0]['extraction'] as Map<String, dynamic>)..removeWhere((key, value) => value == null));
        expect(TreatmentPlanPropertyModel.fromEntity(tResultModel.treatmentPlan![0].simpleImplant!).toJson()..removeWhere((key, value) => value==null),
            ((tAllJson["treatmentPlan"] as List<dynamic>)[0]['simpleImplant'] as Map<String, dynamic>)..removeWhere((key, value) => value == null));
      },
    );
  });
}
