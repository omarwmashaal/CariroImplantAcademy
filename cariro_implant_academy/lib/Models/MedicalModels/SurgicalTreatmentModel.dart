import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/MembraneModel.dart';
import 'package:cariro_implant_academy/Models/TacCompanyModel.dart';

import 'TreatmentPlanModel.dart';

class SurgicalTreatmentModel {
  int? id;
  int? patientId;
  bool? guidedBoneRegeneration;
  bool? guidedBoneRegenerationBlockGraft;
  bool? guidedBoneRegenerationBlockGraftChin;
  bool? guidedBoneRegenerationBlockGraftRamus;
  bool? guidedBoneRegenerationBlockGraftTuberosity;
  String? guidedBoneRegenerationBlockGraftOther;
  bool? guidedBoneRegenerationCutBy;
  bool? guidedBoneRegenerationCutByDisc;
  bool? guidedBoneRegenerationCutByPiezo;
  bool? guidedBoneRegenerationCutByScrews;
  int? guidedBoneRegenerationCutByScrewsNumber;
  bool? guidedBoneRegenerationBoneParticle;
  int? guidedBoneRegenerationBoneParticle100Autogenous;
  int? guidedBoneRegenerationBoneParticle100Xenograft;
  bool? guidedBoneRegenerationACMBur;
  String? guidedBoneRegenerationACMBurArea;
  String? guidedBoneRegenerationACMBurNotes;
  bool? openSinusLift;
  bool? openSinusLiftApproach;
  String? openSinusLiftApproachString;
  bool? openSinusLiftFillMaterial;
  String? openSinusLiftFillMaterialString;
  int? openSinusLift_MembraneID;
  MembraneModel? openSinusLift_Membrane;
  int? openSinusLift_Membrane_CompanyID;
  DropDownDTO? openSinusLift_Membrane_Company;
  int? openSinusLiftTacsNumber;
  int? openSinusLift_TacsCompanyID;
  TacCompanyModel? openSinusLift_TacsCompany;
  bool? softTissueGraft;
  bool? softTissueGraftSurgeryType;
  bool? softTissueGraftSurgeryTypeSoftTissueGraft;
  bool? softTissueGraftSurgeryTypeAdvanced;
  bool? softTissueGraftSurgeryTypeFreeGinivalGraft;
  bool? softTissueGraftSurgeryTypeConnectiveTissueGraft;
  String? softTissueGraftSurgeryTypeSurgeryTechnique;
  bool? softTissueGraftExposure;
  String? softTissueGraftExposureCustomizedHealingCollarTeethNumber;
  bool? softTissueGraftDonorSite;
  String? softTissueGraftDonorSiteNotes;
  bool? softTissueGraftSuture;
  String? softTissueGraftSutureMaterial;
  String? softTissueGraftSutureTechnique;
  String? softTissueGraftSuturePackType;
  bool? softTissueGraftRecipientSite;
  String? softTissueGraftRecipientSiteArea;
  bool? softTissueGraftAugmentation;
  bool? softTissueGraftAugmentationBuccal;
  bool? softTissueGraftAugmentationCrestal;
  bool? softTissueGraftAugmentationLingual;
  bool? softTissueGraftAugmentationMesial;
  bool? softTissueGraftAugmentationDistal;
  bool? softTissueGraftFrenectomy;
  String? softTissueGraftFrenectomyNotes;
  bool? softTissueGraftBoneGraft;
  String? softTissueGraftBoneGraftNotes;
  bool? sutureAndTemporizationAndXRay;
  bool? sutureAndTemporizationAndXRaySutureSize;
  bool? sutureAndTemporizationAndXRaySutureSize30;
  bool? sutureAndTemporizationAndXRaySutureSize40;
  bool? sutureAndTemporizationAndXRaySutureSize50;
  bool? sutureAndTemporizationAndXRaySutureSize60;
  bool? sutureAndTemporizationAndXRaySutureSize70;
  bool? sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal;
  bool? sutureAndTemporizationAndXRayMaterial;
  bool? sutureAndTemporizationAndXRayMaterialVicryl;
  bool? sutureAndTemporizationAndXRayMaterialProline;
  bool? sutureAndTemporizationAndXRayMaterialXRay;
  String? sutureAndTemporizationAndXRayMaterialSutureTechnique;
  bool? sutureAndTemporizationAndXRayTemporary;
  bool? sutureAndTemporizationAndXRayTemporaryHealingCollar;
  bool? sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar;
  bool? sutureAndTemporizationAndXRayTemporaryCrown;
  bool? sutureAndTemporizationAndXRayTemporaryMarylandBridge;
  bool? sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth;
  bool? sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber;
  String? date;
  List<TreatmentPlanSubModel>? surgicalTreatment;

  SurgicalTreatmentModel(
      {this.id,
      this.patientId,
      this.guidedBoneRegeneration = false,
      this.guidedBoneRegenerationBlockGraft = false,
      this.guidedBoneRegenerationBlockGraftChin = false,
      this.guidedBoneRegenerationBlockGraftRamus = false,
      this.guidedBoneRegenerationBlockGraftTuberosity = false,
      this.guidedBoneRegenerationBlockGraftOther,
      this.guidedBoneRegenerationCutBy = false,
      this.guidedBoneRegenerationCutByDisc = false,
      this.guidedBoneRegenerationCutByPiezo = false,
      this.guidedBoneRegenerationCutByScrews = false,
      this.guidedBoneRegenerationCutByScrewsNumber=0,
      this.guidedBoneRegenerationBoneParticle = false,
      this.guidedBoneRegenerationBoneParticle100Autogenous = 0,
      this.guidedBoneRegenerationBoneParticle100Xenograft = 0,
      this.guidedBoneRegenerationACMBur = false,
      this.guidedBoneRegenerationACMBurArea,
      this.guidedBoneRegenerationACMBurNotes,
      this.openSinusLift = false,
      this.openSinusLiftApproach = false,
      this.openSinusLiftApproachString,
      this.openSinusLiftFillMaterial = false,
      this.openSinusLiftFillMaterialString,
      this.openSinusLift_MembraneID,
      this.openSinusLift_Membrane,
      this.openSinusLift_Membrane_CompanyID,
      this.openSinusLift_Membrane_Company,
      this.openSinusLift_TacsCompany,
      this.openSinusLift_TacsCompanyID,
      this.openSinusLiftTacsNumber,
      this.softTissueGraft = false,
      this.softTissueGraftSurgeryType = false,
      this.softTissueGraftSurgeryTypeSoftTissueGraft = false,
      this.softTissueGraftSurgeryTypeAdvanced = false,
      this.softTissueGraftSurgeryTypeFreeGinivalGraft = false,
      this.softTissueGraftSurgeryTypeConnectiveTissueGraft = false,
      this.softTissueGraftSurgeryTypeSurgeryTechnique,
      this.softTissueGraftExposure = false,
      this.softTissueGraftExposureCustomizedHealingCollarTeethNumber,
      this.softTissueGraftDonorSite = false,
      this.softTissueGraftDonorSiteNotes,
      this.softTissueGraftSuture = false,
      this.softTissueGraftSutureMaterial,
      this.softTissueGraftSutureTechnique,
      this.softTissueGraftSuturePackType,
      this.softTissueGraftRecipientSite = false,
      this.softTissueGraftRecipientSiteArea,
      this.softTissueGraftAugmentation = false,
      this.softTissueGraftAugmentationBuccal = false,
      this.softTissueGraftAugmentationCrestal = false,
      this.softTissueGraftAugmentationLingual = false,
      this.softTissueGraftAugmentationMesial = false,
      this.softTissueGraftAugmentationDistal = false,
      this.softTissueGraftFrenectomy = false,
      this.softTissueGraftFrenectomyNotes,
      this.softTissueGraftBoneGraft = false,
      this.softTissueGraftBoneGraftNotes,
      this.sutureAndTemporizationAndXRay = false,
      this.sutureAndTemporizationAndXRaySutureSize = false,
      this.sutureAndTemporizationAndXRaySutureSize30 = false,
      this.sutureAndTemporizationAndXRaySutureSize40 = false,
      this.sutureAndTemporizationAndXRaySutureSize50 = false,
      this.sutureAndTemporizationAndXRaySutureSize60 = false,
      this.sutureAndTemporizationAndXRaySutureSize70 = false,
      this.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false,
      this.sutureAndTemporizationAndXRayMaterial = false,
      this.sutureAndTemporizationAndXRayMaterialVicryl = false,
      this.sutureAndTemporizationAndXRayMaterialProline = false,
      this.sutureAndTemporizationAndXRayMaterialXRay = false,
      this.sutureAndTemporizationAndXRayMaterialSutureTechnique,
      this.sutureAndTemporizationAndXRayTemporary = false,
      this.sutureAndTemporizationAndXRayTemporaryHealingCollar = false,
      this.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar = false,
      this.sutureAndTemporizationAndXRayTemporaryCrown = false,
      this.sutureAndTemporizationAndXRayTemporaryMarylandBridge = false,
      this.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth = false,
      this.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber = false,
      this.date,
      this.surgicalTreatment});

  SurgicalTreatmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surgicalTreatment = ((json['surgicalTreatment'] ?? []) as List<dynamic>).map((e) => TreatmentPlanSubModel.fromJson(e)).toList();
    patientId = json['patientId'];
    guidedBoneRegeneration = json['guidedBoneRegeneration'] ?? false;
    guidedBoneRegenerationBlockGraft = json['guidedBoneRegeneration_BlockGraft'] ?? false;
    guidedBoneRegenerationBlockGraftChin = json['guidedBoneRegeneration_BlockGraft_Chin'] ?? false;
    guidedBoneRegenerationBlockGraftRamus = json['guidedBoneRegeneration_BlockGraft_Ramus'] ?? false ?? false;
    guidedBoneRegenerationBlockGraftTuberosity = json['guidedBoneRegeneration_BlockGraft_Tuberosity'] ?? false ?? false;
    guidedBoneRegenerationBlockGraftOther = json['guidedBoneRegeneration_BlockGraft_Other']??"";
    guidedBoneRegenerationCutBy = json['guidedBoneRegeneration_CutBy'] ?? false;
    guidedBoneRegenerationCutByDisc = json['guidedBoneRegeneration_CutBy_Disc'] ?? false;
    guidedBoneRegenerationCutByPiezo = json['guidedBoneRegeneration_CutBy_Piezo'] ?? false;
    guidedBoneRegenerationCutByScrews = json['guidedBoneRegeneration_CutBy_Screws'] ?? false;
    guidedBoneRegenerationCutByScrewsNumber = json['guidedBoneRegeneration_CutBy_ScrewsNumber']??0;
    guidedBoneRegenerationBoneParticle = json['guidedBoneRegeneration_BoneParticle'] ?? false;
    guidedBoneRegenerationBoneParticle100Autogenous = json['guidedBoneRegeneration_BoneParticle_100Autogenous'] ?? 0;
    guidedBoneRegenerationBoneParticle100Xenograft = json['guidedBoneRegeneration_BoneParticle_100Xenograft'] ?? 100-(guidedBoneRegenerationBoneParticle100Autogenous??0);
    guidedBoneRegenerationACMBur = json['guidedBoneRegeneration_ACMBur'] ?? false;
    guidedBoneRegenerationACMBurArea = json['guidedBoneRegeneration_ACMBur_Area']??"";
    guidedBoneRegenerationACMBurNotes = json['guidedBoneRegeneration_ACMBur_Notes']??"";
    openSinusLift = json['openSinusLift'] ?? false;
    openSinusLiftApproach = json['openSinusLift_Approach'] ?? false;
    openSinusLiftApproachString = json['openSinusLift_Approach_String']??"";
    openSinusLiftFillMaterial = json['openSinusLift_FillMaterial'] ?? false;
    openSinusLiftFillMaterialString = json['openSinusLift_FillMaterial_String']??"";
    openSinusLift_MembraneID = json['openSinusLift_MembraneID'];
    openSinusLift_Membrane = MembraneModel.fromJson(json['openSinusLift_Membrane']??Map<String,dynamic>());
    openSinusLift_Membrane_CompanyID = json['openSinusLift_Membrane_CompanyID'];
    openSinusLift_Membrane_Company = json['openSinusLift_Membrane_Company'] != null ? new DropDownDTO.fromJson(json['openSinusLift_Membrane_Company']) : null;
    openSinusLift_TacsCompany = TacCompanyModel.fromJson(json['openSinusLift_TacsCompany']??Map<String,dynamic>());
    openSinusLift_TacsCompanyID = json['openSinusLift_TacsCompanyID'];
    openSinusLiftTacsNumber = json['openSinusLiftTacsNumber'];
    softTissueGraft = json['softTissueGraft'] ?? false;
    softTissueGraftSurgeryType = json['softTissueGraft_SurgeryType'] ?? false;
    softTissueGraftSurgeryTypeSoftTissueGraft = json['softTissueGraft_SurgeryType_SoftTissueGraft'] ?? false;
    softTissueGraftSurgeryTypeAdvanced = json['softTissueGraft_SurgeryType_Advanced'] ?? false;
    softTissueGraftSurgeryTypeFreeGinivalGraft = json['softTissueGraft_SurgeryType_FreeGinivalGraft'] ?? false;
    softTissueGraftSurgeryTypeConnectiveTissueGraft = json['softTissueGraft_SurgeryType_ConnectiveTissueGraft'] ?? false;
    softTissueGraftSurgeryTypeSurgeryTechnique = json['softTissueGraft_SurgeryType_SurgeryTechnique']??"";
    softTissueGraftExposure = json['softTissueGraft_Exposure'] ?? false;
    softTissueGraftExposureCustomizedHealingCollarTeethNumber = json['softTissueGraft_Exposure_CustomizedHealingCollarTeethNumber']??"";
    softTissueGraftDonorSite = json['softTissueGraft_DonorSite'] ?? false;
    softTissueGraftDonorSiteNotes = json['softTissueGraft_DonorSite_Notes']??"";
    softTissueGraftSuture = json['softTissueGraft_Suture'] ?? false;
    softTissueGraftSutureMaterial = json['softTissueGraft_Suture_Material']??"";
    softTissueGraftSutureTechnique = json['softTissueGraft_Suture_Technique']??"";
    softTissueGraftSuturePackType = json['softTissueGraft_Suture_PackType']??"";
    softTissueGraftRecipientSite = json['softTissueGraft_RecipientSite'] ?? false;
    softTissueGraftRecipientSiteArea = json['softTissueGraft_RecipientSite_Area']??"";
    softTissueGraftAugmentation = json['softTissueGraft_Augmentation'] ?? false;
    softTissueGraftAugmentationBuccal = json['softTissueGraft_Augmentation_Buccal'] ?? false;
    softTissueGraftAugmentationCrestal = json['softTissueGraft_Augmentation_Crestal'] ?? false;
    softTissueGraftAugmentationLingual = json['softTissueGraft_Augmentation_Lingual'] ?? false;
    softTissueGraftAugmentationMesial = json['softTissueGraft_Augmentation_Mesial'] ?? false;
    softTissueGraftAugmentationDistal = json['softTissueGraft_Augmentation_Distal'] ?? false;
    softTissueGraftFrenectomy = json['softTissueGraft_Frenectomy'] ?? false;
    softTissueGraftFrenectomyNotes = json['softTissueGraft_Frenectomy_Notes']??"";
    softTissueGraftBoneGraft = json['softTissueGraft_BoneGraft'] ?? false;
    softTissueGraftBoneGraftNotes = json['softTissueGraft_BoneGraft_Notes']??"";
    sutureAndTemporizationAndXRay = json['sutureAndTemporizationAndXRay'] ?? false;
    sutureAndTemporizationAndXRaySutureSize = json['sutureAndTemporizationAndXRay_SutureSize'] ?? false;
    sutureAndTemporizationAndXRaySutureSize30 = json['sutureAndTemporizationAndXRay_SutureSize_3_0'] ?? false;
    sutureAndTemporizationAndXRaySutureSize40 = json['sutureAndTemporizationAndXRay_SutureSize_4_0'] ?? false;
    sutureAndTemporizationAndXRaySutureSize50 = json['sutureAndTemporizationAndXRay_SutureSize_5_0'] ?? false;
    sutureAndTemporizationAndXRaySutureSize60 = json['sutureAndTemporizationAndXRay_SutureSize_6_0'] ?? false;
    sutureAndTemporizationAndXRaySutureSize70 = json['sutureAndTemporizationAndXRay_SutureSize_7_0'] ?? false;
    sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = json['sutureAndTemporizationAndXRay_SutureSize_ImplantSubcrestal'] ?? false;
    sutureAndTemporizationAndXRayMaterial = json['sutureAndTemporizationAndXRay_Material'] ?? false;
    sutureAndTemporizationAndXRayMaterialVicryl = json['sutureAndTemporizationAndXRay_Material_Vicryl'] ?? false;
    sutureAndTemporizationAndXRayMaterialProline = json['sutureAndTemporizationAndXRay_Material_Proline'] ?? false;
    sutureAndTemporizationAndXRayMaterialXRay = json['sutureAndTemporizationAndXRay_Material_XRay'] ?? false;
    sutureAndTemporizationAndXRayMaterialSutureTechnique = json['sutureAndTemporizationAndXRay_Material_SutureTechnique']??"";
    sutureAndTemporizationAndXRayTemporary = json['sutureAndTemporizationAndXRay_Temporary'] ?? false;
    sutureAndTemporizationAndXRayTemporaryHealingCollar = json['sutureAndTemporizationAndXRay_Temporary_HealingCollar'] ?? false;
    sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar = json['sutureAndTemporizationAndXRay_Temporary_CustomizedHeallingCollar'] ?? false;
    sutureAndTemporizationAndXRayTemporaryCrown = json['sutureAndTemporizationAndXRay_Temporary_Crown'] ?? false;
    sutureAndTemporizationAndXRayTemporaryMarylandBridge = json['sutureAndTemporizationAndXRay_Temporary_MarylandBridge'] ?? false;
    sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth = json['sutureAndTemporizationAndXRay_Temporary_BridgeOnTeeth'] ?? false;
    sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber = json['sutureAndTemporizationAndXRay_Temporary_DentureWithGlassFiber'] ?? false;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['surgicalTreatment'] = (this.surgicalTreatment ?? []).map((e) => e.toJson()).toList();
    data['patientId'] = this.patientId;
    data['guidedBoneRegeneration'] = this.guidedBoneRegeneration;
    data['guidedBoneRegeneration_BlockGraft'] = this.guidedBoneRegenerationBlockGraft;
    data['guidedBoneRegeneration_BlockGraft_Chin'] = this.guidedBoneRegenerationBlockGraftChin;
    data['guidedBoneRegeneration_BlockGraft_Ramus'] = this.guidedBoneRegenerationBlockGraftRamus;
    data['guidedBoneRegeneration_BlockGraft_Tuberosity'] = this.guidedBoneRegenerationBlockGraftTuberosity;
    data['guidedBoneRegeneration_BlockGraft_Other'] = this.guidedBoneRegenerationBlockGraftOther;
    data['guidedBoneRegeneration_CutBy'] = this.guidedBoneRegenerationCutBy;
    data['guidedBoneRegeneration_CutBy_Disc'] = this.guidedBoneRegenerationCutByDisc;
    data['guidedBoneRegeneration_CutBy_Piezo'] = this.guidedBoneRegenerationCutByPiezo;
    data['guidedBoneRegeneration_CutBy_Screws'] = this.guidedBoneRegenerationCutByScrews;
    data['guidedBoneRegeneration_CutBy_ScrewsNumber'] = this.guidedBoneRegenerationCutByScrewsNumber;
    data['guidedBoneRegeneration_BoneParticle'] = this.guidedBoneRegenerationBoneParticle;
    data['guidedBoneRegeneration_BoneParticle_100Autogenous'] = this.guidedBoneRegenerationBoneParticle100Autogenous??0;
    data['guidedBoneRegeneration_BoneParticle_100Xenograft'] = this.guidedBoneRegenerationBoneParticle100Xenograft??100-(this.guidedBoneRegenerationBoneParticle100Autogenous??0);
    data['guidedBoneRegeneration_ACMBur'] = this.guidedBoneRegenerationACMBur;
    data['guidedBoneRegeneration_ACMBur_Area'] = this.guidedBoneRegenerationACMBurArea;
    data['guidedBoneRegeneration_ACMBur_Notes'] = this.guidedBoneRegenerationACMBurNotes;
    data['openSinusLift'] = this.openSinusLift;
    data['openSinusLift_Approach'] = this.openSinusLiftApproach;
    data['openSinusLift_Approach_String'] = this.openSinusLiftApproachString;
    data['openSinusLift_FillMaterial'] = this.openSinusLiftFillMaterial;
    data['openSinusLift_FillMaterial_String'] = this.openSinusLiftFillMaterialString;

    data['openSinusLift_Membrane_CompanyID'] = this.openSinusLift_Membrane_CompanyID;
    data['openSinusLift_MembraneID'] = this.openSinusLift_MembraneID;
    data['openSinusLift_TacsCompanyID'] = this.openSinusLift_TacsCompanyID;
    data['openSinusLiftTacsNumber'] = this.openSinusLiftTacsNumber;

    data['softTissueGraft_SurgeryType'] = this.softTissueGraftSurgeryType;
    data['softTissueGraft_SurgeryType_SoftTissueGraft'] = this.softTissueGraftSurgeryTypeSoftTissueGraft;
    data['softTissueGraft_SurgeryType_Advanced'] = this.softTissueGraftSurgeryTypeAdvanced;
    data['softTissueGraft_SurgeryType_FreeGinivalGraft'] = this.softTissueGraftSurgeryTypeFreeGinivalGraft;
    data['softTissueGraft_SurgeryType_ConnectiveTissueGraft'] = this.softTissueGraftSurgeryTypeConnectiveTissueGraft;
    data['softTissueGraft_SurgeryType_SurgeryTechnique'] = this.softTissueGraftSurgeryTypeSurgeryTechnique;
    data['softTissueGraft_Exposure'] = this.softTissueGraftExposure;
    data['softTissueGraft_Exposure_CustomizedHealingCollarTeethNumber'] = this.softTissueGraftExposureCustomizedHealingCollarTeethNumber;
    data['softTissueGraft_DonorSite'] = this.softTissueGraftDonorSite;
    data['softTissueGraft_DonorSite_Notes'] = this.softTissueGraftDonorSiteNotes;
    data['softTissueGraft_Suture'] = this.softTissueGraftSuture;
    data['softTissueGraft_Suture_Material'] = this.softTissueGraftSutureMaterial;
    data['softTissueGraft_Suture_Technique'] = this.softTissueGraftSutureTechnique;
    data['softTissueGraft_Suture_PackType'] = this.softTissueGraftSuturePackType;
    data['softTissueGraft_RecipientSite'] = this.softTissueGraftRecipientSite;
    data['softTissueGraft_RecipientSite_Area'] = this.softTissueGraftRecipientSiteArea;
    data['softTissueGraft_Augmentation'] = this.softTissueGraftAugmentation;
    data['softTissueGraft_Augmentation_Buccal'] = this.softTissueGraftAugmentationBuccal;
    data['softTissueGraft_Augmentation_Crestal'] = this.softTissueGraftAugmentationCrestal;
    data['softTissueGraft_Augmentation_Lingual'] = this.softTissueGraftAugmentationLingual;
    data['softTissueGraft_Augmentation_Mesial'] = this.softTissueGraftAugmentationMesial;
    data['softTissueGraft_Augmentation_Distal'] = this.softTissueGraftAugmentationDistal;
    data['softTissueGraft_Frenectomy'] = this.softTissueGraftFrenectomy;
    data['softTissueGraft_Frenectomy_Notes'] = this.softTissueGraftFrenectomyNotes;
    data['softTissueGraft_BoneGraft'] = this.softTissueGraftBoneGraft;
    data['softTissueGraft_BoneGraft_Notes'] = this.softTissueGraftBoneGraftNotes;
    data['sutureAndTemporizationAndXRay'] = this.sutureAndTemporizationAndXRay;
    data['sutureAndTemporizationAndXRay_SutureSize'] = this.sutureAndTemporizationAndXRaySutureSize;
    data['sutureAndTemporizationAndXRay_SutureSize_3_0'] = this.sutureAndTemporizationAndXRaySutureSize30;
    data['sutureAndTemporizationAndXRay_SutureSize_4_0'] = this.sutureAndTemporizationAndXRaySutureSize40;
    data['sutureAndTemporizationAndXRay_SutureSize_5_0'] = this.sutureAndTemporizationAndXRaySutureSize50;
    data['sutureAndTemporizationAndXRay_SutureSize_6_0'] = this.sutureAndTemporizationAndXRaySutureSize60;
    data['sutureAndTemporizationAndXRay_SutureSize_7_0'] = this.sutureAndTemporizationAndXRaySutureSize70;
    data['sutureAndTemporizationAndXRay_SutureSize_ImplantSubcrestal'] = this.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal;
    data['sutureAndTemporizationAndXRay_Material'] = this.sutureAndTemporizationAndXRayMaterial;
    data['sutureAndTemporizationAndXRay_Material_Vicryl'] = this.sutureAndTemporizationAndXRayMaterialVicryl;
    data['sutureAndTemporizationAndXRay_Material_Proline'] = this.sutureAndTemporizationAndXRayMaterialProline;
    data['sutureAndTemporizationAndXRay_Material_XRay'] = this.sutureAndTemporizationAndXRayMaterialXRay;
    data['sutureAndTemporizationAndXRay_Material_SutureTechnique'] = this.sutureAndTemporizationAndXRayMaterialSutureTechnique;
    data['sutureAndTemporizationAndXRay_Temporary'] = this.sutureAndTemporizationAndXRayTemporary;
    data['sutureAndTemporizationAndXRay_Temporary_HealingCollar'] = this.sutureAndTemporizationAndXRayTemporaryHealingCollar;
    data['sutureAndTemporizationAndXRay_Temporary_CustomizedHeallingCollar'] = this.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar;
    data['sutureAndTemporizationAndXRay_Temporary_Crown'] = this.sutureAndTemporizationAndXRayTemporaryCrown;
    data['sutureAndTemporizationAndXRay_Temporary_MarylandBridge'] = this.sutureAndTemporizationAndXRayTemporaryMarylandBridge;
    data['sutureAndTemporizationAndXRay_Temporary_BridgeOnTeeth'] = this.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth;
    data['sutureAndTemporizationAndXRay_Temporary_DentureWithGlassFiber'] = this.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber;
    data['date'] = this.date;
    return data;
  }

  Compare(SurgicalTreatmentModel model)
  {
    return this.toJson()==model.toJson();
  }
}
