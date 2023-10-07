import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'labStepEntity.dart';

class LabRequestEntity extends Equatable {
  int? id;
  DateTime? date;
  DateTime? deliveryDate;
  int? entryById;
  BasicNameIdObjectEntity? entryBy;
  int? assignedToId;
  BasicNameIdObjectEntity? assignedTo;
  EnumLabRequestSources? source;
  int? customerId;
  UserEntity? customer;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  EnumLabRequestStatus? status;
  bool? paid;
  int? cost;
  int? paidAmount;
  String? notes;
  String? requiredStep;
  List<LabStepEntity>? steps;
  List<int>? teeth;
  EnumLabRequestInitStatus? initStatus;

  int? fileId;
  BasicNameIdObjectEntity? file;
  bool? fullZireonCrown;
  bool? porcelainFusedToZircomium;
  bool? porcelainFusedToMetal;
  bool? porcelainFusedToMetalCADCAMCoCrAlloy;
  bool? glassCeramicCrown;
  bool? visiolignBondedToPEEK;
  bool? laminateVeneer;
  bool? milledPMMATemporaryCrown;
  bool? longTermTemporaryCrown;
  bool? screwRatainedCrown;
  bool? surveyCrownForRPD;
  bool? surveyCrownWithExtraCoronalAttahcment;
  bool? castPostcore;
  bool? zirconiumPostAndCore;
  bool? customCarbonFiberPost;
  bool? zirconiumInlayOrOnlay;
  bool? glassCeramicInlayOrOnlay;
  bool? caDCAMAbutment;
  bool? specialTray;
  bool? occlusionBlock;
  bool? diagnosticOrTrailSetup;
  bool? flexibleRPD;
  bool? metallicRPD;
  bool? nightGuardVacuumTemplate;
  bool? radiographicDuplicatesForCBCT;
  bool? clearSurgicalTemplates;
  bool? diagnosticSurveying;

  List<String> getMedicalInfoList() {
    List<String> r = [];
    if (fullZireonCrown ?? false) r.add("Full Zireon Crown");
    if (porcelainFusedToZircomium ?? false) r.add("Porcelain Fused To Zircomium");
    if (porcelainFusedToMetal ?? false) r.add("Porcelain Fused ToMetal");
    if (porcelainFusedToMetalCADCAMCoCrAlloy ?? false) r.add("Porcelain Fused To Metal CAD-CAM-Co-Cr Alloy");
    if (glassCeramicCrown ?? false) r.add("Glass Ceramic Crown");
    if (visiolignBondedToPEEK ?? false) r.add("Visiolign Bonded To PEEK");
    if (laminateVeneer ?? false) r.add("Laminate Veneer");
    if (milledPMMATemporaryCrown ?? false) r.add("Milled PMMA TemporaryCrown");
    if (longTermTemporaryCrown ?? false) r.add("Long Term Temporary Crown");
    if (screwRatainedCrown ?? false) r.add("Screw Ratained Crown");
    if (surveyCrownForRPD ?? false) r.add("Survey Crown For RPD");
    if (surveyCrownWithExtraCoronalAttahcment ?? false) r.add("Survey Crown With Extra Coronal Attahcment");
    if (castPostcore ?? false) r.add("Cast Postcore");
    if (zirconiumPostAndCore ?? false) r.add("Zirconium Post And Core");
    if (customCarbonFiberPost ?? false) r.add("Custom Carbon Fiber Post");
    if (zirconiumInlayOrOnlay ?? false) r.add("Zirconium Inlay Or Onlay");
    if (glassCeramicInlayOrOnlay ?? false) r.add("Glass Ceramic Inlay Or Onlay");
    if (caDCAMAbutment ?? false) r.add("CaDCAMAbutment");
    if (specialTray ?? false) r.add("Special Tray");
    if (occlusionBlock ?? false) r.add("Occlusion Block");
    if (diagnosticOrTrailSetup ?? false) r.add("Diagnostic Or Trail Setup");
    if (flexibleRPD ?? false) r.add("Flexible RPD");
    if (metallicRPD ?? false) r.add("Metallic RPD");
    if (nightGuardVacuumTemplate ?? false) r.add("Night Guard Vacuum Template");
    if (radiographicDuplicatesForCBCT ?? false) r.add("Radiographic Duplicates For CBCT");
    if (clearSurgicalTemplates ?? false) r.add("Clear Surgical Templates");
    if (diagnosticSurveying ?? false) r.add("Diagnostic Surveying");
    return r;
  }

  LabRequestEntity(
      {this.id,
      this.date,
      this.deliveryDate,
      this.entryById,
      this.entryBy,
      this.source,
      this.customerId,
      this.customer,
      this.patientId,
      this.patient,
      this.status,
      this.paid,
      this.cost,
      this.paidAmount,
      this.notes,
      this.requiredStep,
      this.steps,
      this.fileId,
      this.file,
      this.fullZireonCrown = false,
      this.porcelainFusedToZircomium = false,
      this.porcelainFusedToMetal = false,
      this.porcelainFusedToMetalCADCAMCoCrAlloy = false,
      this.glassCeramicCrown = false,
      this.visiolignBondedToPEEK = false,
      this.laminateVeneer = false,
      this.milledPMMATemporaryCrown = false,
      this.longTermTemporaryCrown = false,
      this.screwRatainedCrown = false,
      this.surveyCrownForRPD = false,
      this.surveyCrownWithExtraCoronalAttahcment = false,
      this.castPostcore = false,
      this.zirconiumPostAndCore = false,
      this.customCarbonFiberPost = false,
      this.zirconiumInlayOrOnlay = false,
      this.glassCeramicInlayOrOnlay = false,
      this.caDCAMAbutment = false,
      this.specialTray = false,
      this.occlusionBlock = false,
      this.diagnosticOrTrailSetup = false,
      this.flexibleRPD = false,
      this.metallicRPD = false,
      this.initStatus = EnumLabRequestInitStatus.Scan,
      this.nightGuardVacuumTemplate = false,
      this.radiographicDuplicatesForCBCT = false,
      this.clearSurgicalTemplates = false,
      this.teeth,
      this.diagnosticSurveying = false}) {
    entryBy = BasicNameIdObjectEntity();
    customer = UserEntity();
    patient = BasicNameIdObjectEntity();
    file = BasicNameIdObjectEntity();
    teeth = [];
  }

  @override
  List<Object?> get props => [
        this.id,
        this.date,
        this.deliveryDate,
        this.entryById,
        this.entryBy,
        this.source,
        this.customerId,
        this.customer,
        this.patientId,
        this.patient,
        this.status,
        this.paid,
        this.cost,
        this.paidAmount,
        this.notes,
        this.requiredStep,
        this.steps,
        this.fileId,
        this.file,
        this.fullZireonCrown ,
        this.porcelainFusedToZircomium ,
        this.porcelainFusedToMetal ,
        this.porcelainFusedToMetalCADCAMCoCrAlloy ,
        this.glassCeramicCrown ,
        this.visiolignBondedToPEEK ,
        this.laminateVeneer ,
        this.milledPMMATemporaryCrown ,
        this.longTermTemporaryCrown ,
        this.screwRatainedCrown ,
        this.surveyCrownForRPD ,
        this.surveyCrownWithExtraCoronalAttahcment ,
        this.castPostcore ,
        this.zirconiumPostAndCore ,
        this.customCarbonFiberPost ,
        this.zirconiumInlayOrOnlay ,
        this.glassCeramicInlayOrOnlay ,
        this.caDCAMAbutment ,
        this.specialTray ,
        this.occlusionBlock ,
        this.diagnosticOrTrailSetup ,
        this.flexibleRPD ,
        this.metallicRPD ,
        this.initStatus ,
        this.nightGuardVacuumTemplate ,
        this.radiographicDuplicatesForCBCT ,
        this.clearSurgicalTemplates ,
        this.teeth,
        this.diagnosticSurveying
      ];
}

