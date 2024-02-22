import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/models/complicationsAfterProsthesisModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/models/complicationsAfterSurgeryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:get/get.dart';

class AdvancedTreatmentSearchModel extends AdvancedTreatmentSearchEntity {
  AdvancedTreatmentSearchModel({
    super.id,
    super.ids,
    super.tooth,
    super.secondaryId,
    super.patientName,
    super.done,
    super.scaling,
    super.str_implantFailed,
    super.crown,
    super.rootCanalTreatment,
    super.restoration,
    super.pontic,
    super.extraction,
    super.simpleImplant,
    super.immediateImplant,
    super.expansionWithImplant,
    super.implantFailed,
    super.complicationsAfterSurgery,
    super.complicationsAfterSurgeryOr,
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
    super.str_complicationsAfterSurgery,
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
    super.and_scaling,
    super.and_crown,
    super.and_rootCanalTreatment,
    super.and_restoration,
    super.and_pontic,
    super.and_extraction,
    super.and_simpleImplant,
    super.and_immediateImplant,
    super.and_expansionWithImplant,
    super.and_splittingWithImplant,
    super.and_gbrWithImplant,
    super.and_openSinusWithImplant,
    super.and_closedSinusWithImplant,
    super.and_guidedImplant,
    super.and_expansionWithoutImplant,
    super.and_splittingWithoutImplant,
    super.and_gbrWithoutImplant,
    super.and_openSinusWithoutImplant,
    super.and_closedSinusWithoutImplant,
  });

  factory AdvancedTreatmentSearchModel.fromEntity(AdvancedTreatmentSearchEntity entity) {
    return AdvancedTreatmentSearchModel(
      id: entity.id,
      ids: entity.ids,
      secondaryId: entity.secondaryId,
      complicationsAfterSurgeryOr: entity.complicationsAfterSurgeryOr,
      patientName: entity.patientName,
      done: entity.done,
      scaling: entity.scaling,
      noTreatmentPlan: entity.noTreatmentPlan,
      crown: entity.crown,
      rootCanalTreatment: entity.rootCanalTreatment,
      restoration: entity.restoration,
      implantFailed: entity.implantFailed,
      complicationsAfterSurgery: entity.complicationsAfterSurgery,
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
      and_scaling: entity.and_scaling,
      and_crown: entity.and_crown,
      and_rootCanalTreatment: entity.and_rootCanalTreatment,
      and_restoration: entity.and_restoration,
      and_pontic: entity.and_pontic,
      and_extraction: entity.and_extraction,
      and_simpleImplant: entity.and_simpleImplant,
      and_immediateImplant: entity.and_immediateImplant,
      and_expansionWithImplant: entity.and_expansionWithImplant,
      and_splittingWithImplant: entity.and_splittingWithImplant,
      and_gbrWithImplant: entity.and_gbrWithImplant,
      and_openSinusWithImplant: entity.and_openSinusWithImplant,
      and_closedSinusWithImplant: entity.and_closedSinusWithImplant,
      and_guidedImplant: entity.and_guidedImplant,
      and_expansionWithoutImplant: entity.and_expansionWithoutImplant,
      and_splittingWithoutImplant: entity.and_splittingWithoutImplant,
      and_gbrWithoutImplant: entity.and_gbrWithoutImplant,
      and_openSinusWithoutImplant: entity.and_openSinusWithoutImplant,
      and_closedSinusWithoutImplant: entity.and_closedSinusWithoutImplant,
    );
  }

  AdvancedTreatmentSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tooth = json['tooth'];
    secondaryId = json['secondaryId'];
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
    str_complicationsAfterSurgery = json['str_ComplicationsAfterSurgery'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ids'] = this.ids?.map((e) => e as int).toList();
    data['secondaryId'] = this.secondaryId;
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

    data['and_scaling'] = this.and_scaling;
    data['and_crown'] = this.and_crown;
    data['and_rootCanalTreatment'] = this.and_rootCanalTreatment;
    data['and_restoration'] = this.and_restoration;
    data['and_pontic'] = this.and_pontic;
    data['and_extraction'] = this.and_extraction;
    data['and_simpleImplant'] = this.and_simpleImplant;
    data['and_immediateImplant'] = this.and_immediateImplant;
    data['and_expansionWithImplant'] = this.and_expansionWithImplant;
    data['and_splittingWithImplant'] = this.and_splittingWithImplant;
    data['and_gbrWithImplant'] = this.and_gbrWithImplant;
    data['and_openSinusWithImplant'] = this.and_openSinusWithImplant;
    data['and_closedSinusWithImplant'] = this.and_closedSinusWithImplant;
    data['and_guidedImplant'] = this.and_guidedImplant;
    data['and_expansionWithoutImplant'] = this.and_expansionWithoutImplant;
    data['and_splittingWithoutImplant'] = this.and_splittingWithoutImplant;
    data['and_gbrWithoutImplant'] = this.and_gbrWithoutImplant;
    data['and_openSinusWithoutImplant'] = this.and_openSinusWithoutImplant;
    data['and_closedSinusWithoutImplant'] = this.and_closedSinusWithoutImplant;
    data['implantFailed'] = this.implantFailed;
    data['complicationsAfterSurgery'] =
        this.complicationsAfterSurgery == null ? null : ComplicationsAfterSurgeryModel.fromEntity(this.complicationsAfterSurgery!).toJson();
    data['complicationsAfterSurgeryOr'] =
        this.complicationsAfterSurgeryOr == null ? null : ComplicationsAfterSurgeryModel.fromEntity(this.complicationsAfterSurgeryOr!).toJson();

    return data;
  }
}
