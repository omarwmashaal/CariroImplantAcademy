import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';

class AdvancedTreatmentSearchModel extends AdvancedTreatmentSearchEntity{
  AdvancedTreatmentSearchModel({
    super.id,
    super.patientName,
    super.done,
    super.scaling,
    super.crown,
    super.rootCanalTreatment,
    super.restoration,
    super.pontic,
    super.extraction,
    super.simpleImplant,
    super.immediateImplant,
    super.expansionWithImplant,
    super.splittingWithImplant,
    super.gbrWithImplant,
    super.openSinusWithImplant,
    super.closedSinusWithImplant,
    super.noTreatmentPlan,
    super.guidedImplant,
    super.expansionWithoutImplant,
    super.splittingWithoutImplant,
    super.gbrWithoutImplant,
    super.openSinusWithoutImplant,
    super.closedSinusWithoutImplant,
    super.str_scaling,
    super.str_crown,
    super.str_rootCanalTreatment,
    super.str_restoration,
    super.str_pontic,
    super.str_extraction,
    super.str_simpleImplant,
    super.str_immediateImplant,
    super.str_expansionWithImplant,
    super.str_splittingWithImplant,
    super.str_gbrWithImplant,
    super.str_openSinusWithImplant,
    super.str_closedSinusWithImplant,
    super.str_guidedImplant,
    super.str_expansionWithoutImplant,
    super.str_splittingWithoutImplant,
    super.str_gbrWithoutImplant,
    super.str_openSinusWithoutImplant,
    super.str_closedSinusWithoutImplant,
    super.teethClassification,
});

  factory AdvancedTreatmentSearchModel.fromEntity(AdvancedTreatmentSearchEntity entity)
  {
    return AdvancedTreatmentSearchModel(
      id: entity.id,
      patientName: entity.patientName,
      done: entity.done,
      scaling: entity.scaling,
      noTreatmentPlan: entity.noTreatmentPlan,
      crown: entity.crown,
      rootCanalTreatment: entity.rootCanalTreatment,
      restoration: entity.restoration,
      pontic: entity.pontic,
      extraction: entity.extraction,
      simpleImplant: entity.simpleImplant,
      immediateImplant: entity.immediateImplant,
      expansionWithImplant: entity.expansionWithImplant,
      splittingWithImplant: entity.splittingWithImplant,
      gbrWithImplant: entity.gbrWithImplant,
      openSinusWithImplant: entity.openSinusWithImplant,
      closedSinusWithImplant: entity.closedSinusWithImplant,
      guidedImplant: entity.guidedImplant,
      expansionWithoutImplant: entity.expansionWithoutImplant,
      splittingWithoutImplant: entity.splittingWithoutImplant,
      gbrWithoutImplant: entity.gbrWithoutImplant,
      openSinusWithoutImplant: entity.openSinusWithoutImplant,
      closedSinusWithoutImplant: entity.closedSinusWithoutImplant,
      teethClassification: entity.teethClassification,

    );
  }
  AdvancedTreatmentSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patientName'];
    done = json['done'];
    str_scaling = json['scaling'];
    str_crown = json['crown'];
    noTreatmentPlan = json['noTreatmentPlan'];
    str_rootCanalTreatment = json['rootCanalTreatment'];
    str_restoration = json['restoration'];
    str_pontic = json['pontic'];
    str_extraction = json['extraction'];
    str_simpleImplant = json['simpleImplant'];
    str_immediateImplant = json['immediateImplant'];
    str_expansionWithImplant = json['expansionWithImplant'];
    str_splittingWithImplant = json['splittingWithImplant'];
    str_gbrWithImplant = json['gbrWithImplant'];
    str_openSinusWithImplant = json['openSinusWithImplant'];
    str_closedSinusWithImplant = json['closedSinusWithImplant'];
    str_guidedImplant = json['guidedImplant'];
    str_expansionWithoutImplant = json['expansionWithoutImplant'];
    str_splittingWithoutImplant = json['splittingWithoutImplant'];
    str_gbrWithoutImplant = json['gbrWithoutImplant'];
    str_openSinusWithoutImplant = json['openSinusWithoutImplant'];
    str_closedSinusWithoutImplant = json['closedSinusWithoutImplant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientName'] = this.patientName;
    data['done'] = this.done;
    data['scaling'] = this.scaling;
    data['crown'] = this.crown;
    data['rootCanalTreatment'] = this.rootCanalTreatment;
    data['restoration'] = this.restoration;
    data['pontic'] = this.pontic;
    data['extraction'] = this.extraction;
    data['simpleImplant'] = this.simpleImplant;
    data['noTreatmentPlan'] = this.noTreatmentPlan;
    data['immediateImplant'] = this.immediateImplant;
    data['expansionWithImplant'] = this.expansionWithImplant;
    data['splittingWithImplant'] = this.splittingWithImplant;
    data['gbrWithImplant'] = this.gbrWithImplant;
    data['openSinusWithImplant'] = this.openSinusWithImplant;
    data['closedSinusWithImplant'] = this.closedSinusWithImplant;
    data['guidedImplant'] = this.guidedImplant;
    data['expansionWithoutImplant'] = this.expansionWithoutImplant;
    data['splittingWithoutImplant'] = this.splittingWithoutImplant;
    data['gbrWithoutImplant'] = this.gbrWithoutImplant;
    data['openSinusWithoutImplant'] = this.openSinusWithoutImplant;
    data['closedSinusWithoutImplant'] = this.closedSinusWithoutImplant;
    data['teethClassification'] = this.teethClassification == null ? null : this.teethClassification!.index;

    return data;
  }

}