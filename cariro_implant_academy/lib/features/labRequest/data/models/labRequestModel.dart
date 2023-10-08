import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labStepModel.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/user/data/models/userModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums/enums.dart';

class LabRequestModel extends LabRequestEntity {
  LabRequestModel(
      {super.id,
      super.date,
      super.deliveryDate,
      super.entryById,
      super.entryBy,
      super.source,
      super.customerId,
      super.customer,
      super.patientId,
      super.patient,
      super.status,
      super.paid,
      super.cost,
      super.paidAmount,
      super.notes,
      super.requiredStep,
      super.steps,
      super.fileId,
      super.file,
      super.fullZireonCrown,
      super.porcelainFusedToZircomium,
      super.porcelainFusedToMetal,
      super.porcelainFusedToMetalCADCAMCoCrAlloy,
      super.glassCeramicCrown,
      super.visiolignBondedToPEEK,
      super.laminateVeneer,
      super.milledPMMATemporaryCrown,
      super.longTermTemporaryCrown,
      super.screwRatainedCrown,
      super.surveyCrownForRPD,
      super.surveyCrownWithExtraCoronalAttahcment,
      super.castPostcore,
      super.zirconiumPostAndCore,
      super.customCarbonFiberPost,
      super.zirconiumInlayOrOnlay,
      super.glassCeramicInlayOrOnlay,
      super.caDCAMAbutment,
      super.specialTray,
      super.occlusionBlock,
      super.diagnosticOrTrailSetup,
      super.flexibleRPD,
      super.metallicRPD,
      super.initStatus,
      super.nightGuardVacuumTemplate,
      super.radiographicDuplicatesForCBCT,
      super.clearSurgicalTemplates,
      super.teeth,
      super.diagnosticSurveying});

  factory LabRequestModel.fromEntity(LabRequestEntity entity) {
    return LabRequestModel(
        id: entity.id,
        date: entity.date,
        deliveryDate: entity.deliveryDate,
        entryById: entity.entryById,
        entryBy: entity.entryBy,
        source: entity.source,
        customerId: entity.customerId,
        customer: entity.customer,
        patientId: entity.patientId,
        patient: entity.patient,
        status: entity.status,
        paid: entity.paid,
        cost: entity.cost,
        paidAmount: entity.paidAmount,
        notes: entity.notes,
        requiredStep: entity.requiredStep,
        steps: entity.steps,
        fileId: entity.fileId,
        file: entity.file,
        fullZireonCrown: entity.fullZireonCrown,
        porcelainFusedToZircomium: entity.porcelainFusedToZircomium,
        porcelainFusedToMetal: entity.porcelainFusedToMetal,
        porcelainFusedToMetalCADCAMCoCrAlloy: entity.porcelainFusedToMetalCADCAMCoCrAlloy,
        glassCeramicCrown: entity.glassCeramicCrown,
        visiolignBondedToPEEK: entity.visiolignBondedToPEEK,
        laminateVeneer: entity.laminateVeneer,
        milledPMMATemporaryCrown: entity.milledPMMATemporaryCrown,
        longTermTemporaryCrown: entity.longTermTemporaryCrown,
        screwRatainedCrown: entity.screwRatainedCrown,
        surveyCrownForRPD: entity.surveyCrownForRPD,
        surveyCrownWithExtraCoronalAttahcment: entity.surveyCrownWithExtraCoronalAttahcment,
        castPostcore: entity.castPostcore,
        zirconiumPostAndCore: entity.zirconiumPostAndCore,
        customCarbonFiberPost: entity.customCarbonFiberPost,
        zirconiumInlayOrOnlay: entity.zirconiumInlayOrOnlay,
        glassCeramicInlayOrOnlay: entity.glassCeramicInlayOrOnlay,
        caDCAMAbutment: entity.caDCAMAbutment,
        specialTray: entity.specialTray,
        occlusionBlock: entity.occlusionBlock,
        diagnosticOrTrailSetup: entity.diagnosticOrTrailSetup,
        flexibleRPD: entity.flexibleRPD,
        metallicRPD: entity.metallicRPD,
        initStatus: entity.initStatus,
        nightGuardVacuumTemplate: entity.nightGuardVacuumTemplate,
        radiographicDuplicatesForCBCT: entity.radiographicDuplicatesForCBCT,
        clearSurgicalTemplates: entity.clearSurgicalTemplates,
        teeth: entity.teeth,
        diagnosticSurveying: entity.diagnosticSurveying);
  }

  LabRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initStatus = json['initStatus'] != null ? EnumLabRequestInitStatus.values[json['initStatus']] : null;
    teeth = ((json['teeth'] ?? []) as List<dynamic>).map((e) => e as int).toList();
    date = DateTime.tryParse(json['date']??"")?.toLocal();
    deliveryDate = DateTime.tryParse(json['deliveryDate']??"")?.toLocal();
    entryById = json['entryById'];
    entryBy = BasicNameIdObjectModel.fromJson(json['entryBy'] ?? Map<String, dynamic>());
    assignedToId = json['assignedToId'];
    assignedTo = BasicNameIdObjectModel.fromJson(json['assignedTo'] ?? Map<String, dynamic>());
    source = EnumLabRequestSources.values[json['source'] ?? 0];
    customerId = json['customerId'];
    customer = UserModel.fromJson(json['customer'] ?? Map<String, dynamic>());
    patientId = json['patientId'];
    patient = BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    status = EnumLabRequestStatus.values[json['status'] ?? 0];
    paid = json['paid'] ?? false;
    cost = json['cost'];
    paidAmount = json['paidAmount'];
    notes = json['notes'] ?? "";
    requiredStep = json['requiredStep'] ?? "";
    steps = ((json['steps'] ?? []) as List<dynamic>).map((e) => LabStepModel.fromJson(e as Map<String, dynamic>)).toList();
    if (steps != null && steps!.isNotEmpty && this.customerId == steps!.last.technicianId) assignedTo!.name = "Customer";
    fileId = json['fileId'];
    file = BasicNameIdObjectModel.fromJson(json['file'] ?? Map<String, dynamic>());
    fullZireonCrown = json['full_zireon_crown'] ?? false;
    porcelainFusedToZircomium = json['porcelain_fused_to_zircomium'] ?? false;
    porcelainFusedToMetal = json['porcelain_fused_to_metal'] ?? false;
    porcelainFusedToMetalCADCAMCoCrAlloy = json['porcelain_fused_to_metal_CAD_CAM_Co_Cr_alloy'] ?? false;
    glassCeramicCrown = json['glass_ceramic_crown'] ?? false;
    visiolignBondedToPEEK = json['visiolign_bonded_to_PEEK'] ?? false;
    laminateVeneer = json['laminate_veneer'] ?? false;
    milledPMMATemporaryCrown = json['milled_PMMA_temporary_crown'] ?? false;
    longTermTemporaryCrown = json['long_term_temporary_crown'] ?? false;
    screwRatainedCrown = json['screw_ratained_crown'] ?? false;
    surveyCrownForRPD = json['survey_crown_for_RPD'] ?? false;
    surveyCrownWithExtraCoronalAttahcment = json['survey_crown_with_extra_coronal_attahcment'] ?? false;
    castPostcore = json['cast_postcore'] ?? false;
    zirconiumPostAndCore = json['zirconium_post_and_core'] ?? false;
    customCarbonFiberPost = json['custom_carbon_fiber_post'] ?? false;
    zirconiumInlayOrOnlay = json['zirconium_inlay_or_onlay'] ?? false;
    glassCeramicInlayOrOnlay = json['glass_ceramic_inlay_or_onlay'] ?? false;
    caDCAMAbutment = json['caD_CAM_abutment'] ?? false;
    specialTray = json['special_tray'] ?? false;
    occlusionBlock = json['occlusion_block'] ?? false;
    diagnosticOrTrailSetup = json['diagnostic_or_trail_setup'] ?? false;
    flexibleRPD = json['flexible_RPD'] ?? false;
    metallicRPD = json['metallic_RPD'] ?? false;
    nightGuardVacuumTemplate = json['night_guard_vacuum_template'] ?? false;
    radiographicDuplicatesForCBCT = json['radiographic_duplicates_for_CBCT'] ?? false;
    clearSurgicalTemplates = json['clear_surgical_templates'] ?? false;
    diagnosticSurveying = json['diagnostic_surveying'] ?? false;

    if (steps != null) {
      var assigned = steps!.firstWhereOrNull((element) => element.status == LabStepStatus.InProgress);
      if (assigned == null) {
        assigned = steps!.firstWhereOrNull((element) => element.status == LabStepStatus.NotYet);
      }
      if (assigned != null) {
        assignedTo = assignedTo ?? assigned!.technician ?? BasicNameIdObjectModel();
        assignedToId = assignedToId ?? assigned!.technicianId;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['initStatus'] = this.initStatus != null ? this.initStatus!.index : null;
    data['teeth'] = this.teeth ?? [];
    //data['date'] = CIA_DateConverters.fromDateTimeToBackend(this.date);
    data['deliveryDate'] =
        this.deliveryDate == null ? null : DateFormat("yyyy-MM-dd").format(this.deliveryDate!); // CIA_DateConverters.fromDateOnlyToBackend(this.deliveryDate);
    // data['entryById'] = this.entryById;
    // data['entryBy'] = this.entryBy != null ? this.entryBy!.toJson() : null;
    if (this.steps != null && this.steps != []) {
      this.assignedToId = steps![0].technicianId;
    }
    data['assignedToId'] = this.assignedToId;
    //data['assignedTo'] = this.assignedTo != null ? this.assignedTo!.toJson() : null;
    data['source'] = (this.source ?? EnumLabRequestSources.CIA).index;
    data['customerId'] = this.customerId;
    //data['customer'] = this.customer != null ? this.customer!.toJson() : null;
    data['patientId'] = this.patientId;
    //data['patient'] = this.patient != null ? this.patient!.toJson() : null;
    data['status'] = (this.status ?? EnumLabRequestStatus.InQueue).index;
    data['paid'] = this.paid ?? false;
    data['cost'] = this.cost ?? 0;
    data['paidAmount'] = this.paidAmount ?? 0;
    data['notes'] = this.notes;
    data['requiredStep'] = this.requiredStep;
    data['steps'] = (this.steps ?? []).map((e) =>LabStepModel.fromEntity(e) .toJson()).toList();
    data['fileId'] = this.fileId;
    data['file'] = this.file != null ? BasicNameIdObjectModel.fromEntity(this.file!).toJson() : null;
    data['full_zireon_crown'] = this.fullZireonCrown;
    data['porcelain_fused_to_zircomium'] = this.porcelainFusedToZircomium;
    data['porcelain_fused_to_metal'] = this.porcelainFusedToMetal;
    data['porcelain_fused_to_metal_CAD_CAM_Co_Cr_alloy'] = this.porcelainFusedToMetalCADCAMCoCrAlloy;
    data['glass_ceramic_crown'] = this.glassCeramicCrown;
    data['visiolign_bonded_to_PEEK'] = this.visiolignBondedToPEEK;
    data['laminate_veneer'] = this.laminateVeneer;
    data['milled_PMMA_temporary_crown'] = this.milledPMMATemporaryCrown;
    data['long_term_temporary_crown'] = this.longTermTemporaryCrown;
    data['screw_ratained_crown'] = this.screwRatainedCrown;
    data['survey_crown_for_RPD'] = this.surveyCrownForRPD;
    data['survey_crown_with_extra_coronal_attahcment'] = this.surveyCrownWithExtraCoronalAttahcment;
    data['cast_postcore'] = this.castPostcore;
    data['zirconium_post_and_core'] = this.zirconiumPostAndCore;
    data['custom_carbon_fiber_post'] = this.customCarbonFiberPost;
    data['zirconium_inlay_or_onlay'] = this.zirconiumInlayOrOnlay;
    data['glass_ceramic_inlay_or_onlay'] = this.glassCeramicInlayOrOnlay;
    data['caD_CAM_abutment'] = this.caDCAMAbutment;
    data['special_tray'] = this.specialTray;
    data['occlusion_block'] = this.occlusionBlock;
    data['diagnostic_or_trail_setup'] = this.diagnosticOrTrailSetup;
    data['flexible_RPD'] = this.flexibleRPD;
    data['metallic_RPD'] = this.metallicRPD;
    data['night_guard_vacuum_template'] = this.nightGuardVacuumTemplate;
    data['radiographic_duplicates_for_CBCT'] = this.radiographicDuplicatesForCBCT;
    data['clear_surgical_templates'] = this.clearSurgicalTemplates;
    data['diagnostic_surveying'] = this.diagnosticSurveying;
    return data;
  }
}
