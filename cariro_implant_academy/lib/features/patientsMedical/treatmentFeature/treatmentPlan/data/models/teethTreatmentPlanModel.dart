import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/treatmentPlan/data/models/treatmentPlanPropertyModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/treatmentPlan/domain/entities/teethTreatmentPlan.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/treatmentPlan/domain/entities/trearmentPlanPropertyEntity.dart';

class TeethTreatmentPlanModel extends TeethTreatmentPlanEntity{
  TeethTreatmentPlanModel({
    id,
    patientId,
    patient,
    tooth,
    rootCanalTreatment,
    restoration,
    pontic,
    extraction,
    simpleImplant,
    immediateImplant,
    expansionWithImplant,
    splittingWithImplant,
    gbrWithImplant,
    openSinusWithImplant,
    closedSinusWithImplant,
    guidedImplant,
    expansionWithoutImplant,
    splittingWithoutImplant,
    gbrWithoutImplant,
    openSinusWithoutImplant,
    closedSinusWithoutImplant,
    scaling,
    crown,
}):super(
    id:id,
    patientId:patientId,
    patient:patient,
    tooth:tooth,
    rootCanalTreatment:rootCanalTreatment,
    restoration:restoration,
    pontic:pontic,
    extraction:extraction,
    simpleImplant:simpleImplant,
    immediateImplant:immediateImplant,
    expansionWithImplant:expansionWithImplant,
    splittingWithImplant:splittingWithImplant,
    gbrWithImplant:gbrWithImplant,
    openSinusWithImplant:openSinusWithImplant,
    closedSinusWithImplant:closedSinusWithImplant,
    guidedImplant:guidedImplant,
    expansionWithoutImplant:expansionWithoutImplant,
    splittingWithoutImplant:splittingWithoutImplant,
    gbrWithoutImplant:gbrWithoutImplant,
    openSinusWithoutImplant:openSinusWithoutImplant,
    closedSinusWithoutImplant:closedSinusWithoutImplant,
    scaling: scaling,
    crown: crown,
  );
  factory TeethTreatmentPlanModel.fromEntity(TeethTreatmentPlanEntity entity)
  {
    return TeethTreatmentPlanModel(
      id:entity.id,
      patientId:entity.patientId,
      patient:entity.patient,
      tooth:entity.tooth,
      rootCanalTreatment:entity.rootCanalTreatment,
      restoration:entity.restoration,
      pontic:entity.pontic,
      extraction:entity.extraction,
      simpleImplant:entity.simpleImplant,
      immediateImplant:entity.immediateImplant,
      expansionWithImplant:entity.expansionWithImplant,
      splittingWithImplant:entity.splittingWithImplant,
      gbrWithImplant:entity.gbrWithImplant,
      openSinusWithImplant:entity.openSinusWithImplant,
      closedSinusWithImplant:entity.closedSinusWithImplant,
      guidedImplant:entity.guidedImplant,
      expansionWithoutImplant:entity.expansionWithoutImplant,
      splittingWithoutImplant:entity.splittingWithoutImplant,
      gbrWithoutImplant:entity.gbrWithoutImplant,
      openSinusWithoutImplant:entity.openSinusWithoutImplant,
      closedSinusWithoutImplant:entity.closedSinusWithoutImplant,
    );
  }
  TeethTreatmentPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    patient = json['patient'] != null ? new BasicNameIdObjectModel.fromJson(json['patient']) : null;
    tooth = json['tooth'];
    rootCanalTreatment = json['rootCanalTreatment'] != null ? new TreatmentPlanPropertyModel.fromJson(json['rootCanalTreatment']) : null;
    restoration = json['restoration'] != null ? new TreatmentPlanPropertyModel.fromJson(json['restoration']) : null;
    pontic = json['pontic'] != null ? new TreatmentPlanPropertyModel.fromJson(json['pontic']) : null;
    extraction = json['extraction'] != null ? new TreatmentPlanPropertyModel.fromJson(json['extraction']) : null;
    simpleImplant = json['simpleImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['simpleImplant']) : null;
    immediateImplant = json['immediateImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['immediateImplant']) : null;
    expansionWithImplant = json['expansionWithImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['expansionWithImplant']) : null;
    splittingWithImplant = json['splittingWithImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['splittingWithImplant']) : null;
    gbrWithImplant = json['gbrWithImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['gbrWithImplant']) : null;
    openSinusWithImplant = json['openSinusWithImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['openSinusWithImplant']) : null;
    closedSinusWithImplant = json['closedSinusWithImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['closedSinusWithImplant']) : null;
    guidedImplant = json['guidedImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['guidedImplant']) : null;
    expansionWithoutImplant = json['expansionWithoutImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['expansionWithoutImplant']) : null;
    splittingWithoutImplant = json['splittingWithoutImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['splittingWithoutImplant']) : null;
    gbrWithoutImplant = json['gbrWithoutImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['gbrWithoutImplant']) : null;
    openSinusWithoutImplant = json['openSinusWithoutImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['openSinusWithoutImplant']) : null;
    closedSinusWithoutImplant = json['closedSinusWithoutImplant'] != null ? new TreatmentPlanPropertyModel.fromJson(json['closedSinusWithoutImplant']) : null;
    scaling = json['scaling'] != null ? new TreatmentPlanPropertyModel.fromJson(json['scaling']) : null;
    crown = json['crown'] != null ? new TreatmentPlanPropertyModel.fromJson(json['crown']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    if (this.rootCanalTreatment != null) {
      data['rootCanalTreatment'] = TreatmentPlanPropertyModel.fromEntity(this.rootCanalTreatment!).toJson();
    }
    if (this.restoration != null) {
      data['restoration'] = TreatmentPlanPropertyModel.fromEntity(this.restoration!).toJson();
    }
    if (this.pontic != null) {
      data['pontic'] = TreatmentPlanPropertyModel.fromEntity(this.pontic!).toJson();
    }
    if (this.extraction != null) {
      data['extraction'] = TreatmentPlanPropertyModel.fromEntity(this.extraction!).toJson();
    }
    if (this.simpleImplant != null) {
      data['simpleImplant'] = TreatmentPlanPropertyModel.fromEntity(this.simpleImplant!).toJson();
    }
    if (this.immediateImplant != null) {
      data['immediateImplant'] = TreatmentPlanPropertyModel.fromEntity(this.immediateImplant!).toJson();
    }
    if (this.expansionWithImplant != null) {
      data['expansionWithImplant'] = TreatmentPlanPropertyModel.fromEntity(this.expansionWithImplant!).toJson();
    }
    if (this.splittingWithImplant != null) {
      data['splittingWithImplant'] = TreatmentPlanPropertyModel.fromEntity(this.splittingWithImplant!).toJson();
    }
    if (this.gbrWithImplant != null) {
      data['gbrWithImplant'] = TreatmentPlanPropertyModel.fromEntity(this.gbrWithImplant!).toJson();
    }
    if (this.openSinusWithImplant != null) {
      data['openSinusWithImplant'] = TreatmentPlanPropertyModel.fromEntity(this.openSinusWithImplant!).toJson();
    }
    if (this.closedSinusWithImplant != null) {
      data['closedSinusWithImplant'] = TreatmentPlanPropertyModel.fromEntity(this.closedSinusWithImplant!).toJson();
    }
    if (this.guidedImplant != null) {
      data['guidedImplant'] = TreatmentPlanPropertyModel.fromEntity(this.guidedImplant!).toJson();
    }
    if (this.expansionWithoutImplant != null) {
      data['expansionWithoutImplant'] = TreatmentPlanPropertyModel.fromEntity(this.expansionWithoutImplant!).toJson();
    }
    if (this.splittingWithoutImplant != null) {
      data['splittingWithoutImplant'] = TreatmentPlanPropertyModel.fromEntity(this.splittingWithoutImplant!).toJson();
    }
    if (this.gbrWithoutImplant != null) {
      data['gbrWithoutImplant'] = TreatmentPlanPropertyModel.fromEntity(this.gbrWithoutImplant!).toJson();
    }
    if (this.openSinusWithoutImplant != null) {
      data['openSinusWithoutImplant'] = TreatmentPlanPropertyModel.fromEntity(this.openSinusWithoutImplant!).toJson();
    }
    if (this.closedSinusWithoutImplant != null) {
      data['closedSinusWithoutImplant'] = TreatmentPlanPropertyModel.fromEntity(this.closedSinusWithoutImplant!).toJson();
    }
    if (this.scaling != null) {
      data['scaling'] = TreatmentPlanPropertyModel.fromEntity(this.scaling!).toJson();
    }
    if (this.crown != null) {
      data['crown'] = TreatmentPlanPropertyModel.fromEntity(this.crown!).toJson();
    }
    return data;
  }

}