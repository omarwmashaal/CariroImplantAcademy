import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/membraneModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/tacCompanyModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/requestChangeModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/teethTreatmentPlanModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/surgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';

class SurgicalTreatmentModel extends SurgicalTreatmentEntity {
  SurgicalTreatmentModel({
    super.id,
    super.doctor,
    super.requestChanges,
    super.patientId,
    super.guidedBoneRegeneration,
    super.guidedBoneRegenerationBlockGraft,
    super.guidedBoneRegenerationBlockGraftChin,
    super.guidedBoneRegenerationBlockGraftRamus,
    super.guidedBoneRegenerationBlockGraftTuberosity,
    super.guidedBoneRegenerationBlockGraftOther,
    super.guidedBoneRegenerationCutBy,
    super.guidedBoneRegenerationCutByDisc,
    super.guidedBoneRegenerationCutByPiezo,
    super.guidedBoneRegenerationCutByScrews,
    super.guidedBoneRegenerationCutByScrewsNumber,
    super.guidedBoneRegenerationBoneParticle,
    super.guidedBoneRegenerationBoneParticle100Autogenous,
    super.guidedBoneRegenerationBoneParticle100Xenograft,
    super.guidedBoneRegenerationACMBur,
    super.guidedBoneRegenerationACMBurArea,
    super.guidedBoneRegenerationACMBurNotes,
    super.openSinusLift,
    super.openSinusLiftApproach,
    super.openSinusLiftApproachString,
    super.openSinusLiftFillMaterial,
    super.openSinusLiftFillMaterialString,
    super.openSinusLift_MembraneID,
    super.openSinusLift_Membrane,
    super.openSinusLift_Membrane_CompanyID,
    super.openSinusLift_Membrane_Company,
    super.openSinusLift_TacsCompany,
    super.openSinusLift_TacsCompanyID,
    super.openSinusLiftTacsNumber,
    super.softTissueGraft,
    super.softTissueGraftSurgeryType,
    super.softTissueGraftSurgeryTypeSoftTissueGraft,
    super.softTissueGraftSurgeryTypeAdvanced,
    super.softTissueGraftSurgeryTypeFreeGinivalGraft,
    super.softTissueGraftSurgeryTypeConnectiveTissueGraft,
    super.softTissueGraftSurgeryTypeSurgeryTechnique,
    super.softTissueGraftExposure,
    super.softTissueGraftExposureCustomizedHealingCollarTeethNumber,
    super.softTissueGraftDonorSite,
    super.softTissueGraftDonorSiteNotes,
    super.softTissueGraftSuture,
    super.softTissueGraftSutureMaterial,
    super.softTissueGraftSutureTechnique,
    super.softTissueGraftSuturePackType,
    super.softTissueGraftRecipientSite,
    super.softTissueGraftRecipientSiteArea,
    super.softTissueGraftAugmentation,
    super.softTissueGraftAugmentationBuccal,
    super.softTissueGraftAugmentationCrestal,
    super.softTissueGraftAugmentationLingual,
    super.softTissueGraftAugmentationMesial,
    super.softTissueGraftAugmentationDistal,
    super.softTissueGraftFrenectomy,
    super.softTissueGraftFrenectomyNotes,
    super.softTissueGraftBoneGraft,
    super.softTissueGraftBoneGraftNotes,
    super.sutureAndTemporizationAndXRay,
    super.sutureAndTemporizationAndXRaySutureSize,
    super.sutureAndTemporizationAndXRaySutureSize30,
    super.sutureAndTemporizationAndXRaySutureSize40,
    super.sutureAndTemporizationAndXRaySutureSize50,
    super.sutureAndTemporizationAndXRaySutureSize60,
    super.sutureAndTemporizationAndXRaySutureSize70,
    super.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal,
    super.sutureAndTemporizationAndXRayMaterial,
    super.sutureAndTemporizationAndXRayMaterialVicryl,
    super.sutureAndTemporizationAndXRayMaterialProline,
    super.sutureAndTemporizationAndXRayMaterialXRay,
    super.sutureAndTemporizationAndXRayMaterialSutureTechnique,
    super.sutureAndTemporizationAndXRayTemporary,
    super.sutureAndTemporizationAndXRayTemporaryHealingCollar,
    super.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar,
    super.sutureAndTemporizationAndXRayTemporaryCrown,
    super.sutureAndTemporizationAndXRayTemporaryMarylandBridge,
    super.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth,
    super.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber,
    super.date,
    super.surgicalTreatment,
  });
  
  factory SurgicalTreatmentModel.fromEntity(SurgicalTreatmentEntity entity)
  {
    return SurgicalTreatmentModel(
      id:entity.id,
      requestChanges:entity.requestChanges,
      patientId:entity.patientId,
      guidedBoneRegeneration:entity.guidedBoneRegeneration,
      guidedBoneRegenerationBlockGraft:entity.guidedBoneRegenerationBlockGraft,
      guidedBoneRegenerationBlockGraftChin:entity.guidedBoneRegenerationBlockGraftChin,
      guidedBoneRegenerationBlockGraftRamus:entity.guidedBoneRegenerationBlockGraftRamus,
      guidedBoneRegenerationBlockGraftTuberosity:entity.guidedBoneRegenerationBlockGraftTuberosity,
      guidedBoneRegenerationBlockGraftOther:entity.guidedBoneRegenerationBlockGraftOther,
      guidedBoneRegenerationCutBy:entity.guidedBoneRegenerationCutBy,
      guidedBoneRegenerationCutByDisc:entity.guidedBoneRegenerationCutByDisc,
      guidedBoneRegenerationCutByPiezo:entity.guidedBoneRegenerationCutByPiezo,
      guidedBoneRegenerationCutByScrews:entity.guidedBoneRegenerationCutByScrews,
      guidedBoneRegenerationCutByScrewsNumber:entity.guidedBoneRegenerationCutByScrewsNumber,
      guidedBoneRegenerationBoneParticle:entity.guidedBoneRegenerationBoneParticle,
      guidedBoneRegenerationBoneParticle100Autogenous:entity.guidedBoneRegenerationBoneParticle100Autogenous,
      guidedBoneRegenerationBoneParticle100Xenograft:entity.guidedBoneRegenerationBoneParticle100Xenograft,
      guidedBoneRegenerationACMBur:entity.guidedBoneRegenerationACMBur,
      guidedBoneRegenerationACMBurArea:entity.guidedBoneRegenerationACMBurArea,
      guidedBoneRegenerationACMBurNotes:entity.guidedBoneRegenerationACMBurNotes,
      openSinusLift:entity.openSinusLift,
      openSinusLiftApproach:entity.openSinusLiftApproach,
      openSinusLiftApproachString:entity.openSinusLiftApproachString,
      openSinusLiftFillMaterial:entity.openSinusLiftFillMaterial,
      openSinusLiftFillMaterialString:entity.openSinusLiftFillMaterialString,
      openSinusLift_MembraneID:entity.openSinusLift_MembraneID,
      openSinusLift_Membrane:entity.openSinusLift_Membrane,
      openSinusLift_Membrane_CompanyID:entity.openSinusLift_Membrane_CompanyID,
      openSinusLift_Membrane_Company:entity.openSinusLift_Membrane_Company,
      openSinusLift_TacsCompany:entity.openSinusLift_TacsCompany,
      openSinusLift_TacsCompanyID:entity.openSinusLift_TacsCompanyID,
      openSinusLiftTacsNumber:entity.openSinusLiftTacsNumber,
      softTissueGraft:entity.softTissueGraft,
      softTissueGraftSurgeryType:entity.softTissueGraftSurgeryType,
      softTissueGraftSurgeryTypeSoftTissueGraft:entity.softTissueGraftSurgeryTypeSoftTissueGraft,
      softTissueGraftSurgeryTypeAdvanced:entity.softTissueGraftSurgeryTypeAdvanced,
      softTissueGraftSurgeryTypeFreeGinivalGraft:entity.softTissueGraftSurgeryTypeFreeGinivalGraft,
      softTissueGraftSurgeryTypeConnectiveTissueGraft:entity.softTissueGraftSurgeryTypeConnectiveTissueGraft,
      softTissueGraftSurgeryTypeSurgeryTechnique:entity.softTissueGraftSurgeryTypeSurgeryTechnique,
      softTissueGraftExposure:entity.softTissueGraftExposure,
      softTissueGraftExposureCustomizedHealingCollarTeethNumber:entity.softTissueGraftExposureCustomizedHealingCollarTeethNumber,
      softTissueGraftDonorSite:entity.softTissueGraftDonorSite,
      softTissueGraftDonorSiteNotes:entity.softTissueGraftDonorSiteNotes,
      softTissueGraftSuture:entity.softTissueGraftSuture,
      softTissueGraftSutureMaterial:entity.softTissueGraftSutureMaterial,
      softTissueGraftSutureTechnique:entity.softTissueGraftSutureTechnique,
      softTissueGraftSuturePackType:entity.softTissueGraftSuturePackType,
      softTissueGraftRecipientSite:entity.softTissueGraftRecipientSite,
      softTissueGraftRecipientSiteArea:entity.softTissueGraftRecipientSiteArea,
      softTissueGraftAugmentation:entity.softTissueGraftAugmentation,
      softTissueGraftAugmentationBuccal:entity.softTissueGraftAugmentationBuccal,
      softTissueGraftAugmentationCrestal:entity.softTissueGraftAugmentationCrestal,
      softTissueGraftAugmentationLingual:entity.softTissueGraftAugmentationLingual,
      softTissueGraftAugmentationMesial:entity.softTissueGraftAugmentationMesial,
      softTissueGraftAugmentationDistal:entity.softTissueGraftAugmentationDistal,
      softTissueGraftFrenectomy:entity.softTissueGraftFrenectomy,
      softTissueGraftFrenectomyNotes:entity.softTissueGraftFrenectomyNotes,
      softTissueGraftBoneGraft:entity.softTissueGraftBoneGraft,
      softTissueGraftBoneGraftNotes:entity.softTissueGraftBoneGraftNotes,
      sutureAndTemporizationAndXRay:entity.sutureAndTemporizationAndXRay,
      sutureAndTemporizationAndXRaySutureSize:entity.sutureAndTemporizationAndXRaySutureSize,
      sutureAndTemporizationAndXRaySutureSize30:entity.sutureAndTemporizationAndXRaySutureSize30,
      sutureAndTemporizationAndXRaySutureSize40:entity.sutureAndTemporizationAndXRaySutureSize40,
      sutureAndTemporizationAndXRaySutureSize50:entity.sutureAndTemporizationAndXRaySutureSize50,
      sutureAndTemporizationAndXRaySutureSize60:entity.sutureAndTemporizationAndXRaySutureSize60,
      sutureAndTemporizationAndXRaySutureSize70:entity.sutureAndTemporizationAndXRaySutureSize70,
      sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal:entity.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal,
      sutureAndTemporizationAndXRayMaterial:entity.sutureAndTemporizationAndXRayMaterial,
      sutureAndTemporizationAndXRayMaterialVicryl:entity.sutureAndTemporizationAndXRayMaterialVicryl,
      sutureAndTemporizationAndXRayMaterialProline:entity.sutureAndTemporizationAndXRayMaterialProline,
      sutureAndTemporizationAndXRayMaterialXRay:entity.sutureAndTemporizationAndXRayMaterialXRay,
      sutureAndTemporizationAndXRayMaterialSutureTechnique:entity.sutureAndTemporizationAndXRayMaterialSutureTechnique,
      sutureAndTemporizationAndXRayTemporary:entity.sutureAndTemporizationAndXRayTemporary,
      sutureAndTemporizationAndXRayTemporaryHealingCollar:entity.sutureAndTemporizationAndXRayTemporaryHealingCollar,
      sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar:entity.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar,
      sutureAndTemporizationAndXRayTemporaryCrown:entity.sutureAndTemporizationAndXRayTemporaryCrown,
      sutureAndTemporizationAndXRayTemporaryMarylandBridge:entity.sutureAndTemporizationAndXRayTemporaryMarylandBridge,
      sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth:entity.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth,
      sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber:entity.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber,
      date:entity.date,
      surgicalTreatment:entity.surgicalTreatment,
    );
  }

  SurgicalTreatmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestChanges = json['requestChanges']==null?null:((json['requestChanges'] as List<dynamic>).map((e) => RequestChangeModel.fromJson(e as Map<String,dynamic>)).toList());
    doctor = json['doctor']==null?null:BasicNameIdObjectModel.fromJson(json['doctor'] as Map<String,dynamic>);
    surgicalTreatment = ((json['surgicalTreatment'] ?? []) as List<dynamic>).map((e) => TeethTreatmentPlanModel.fromJson(e)).toList();
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
    openSinusLift_Membrane_Company = json['openSinusLift_Membrane_Company'] != null ? new BasicNameIdObjectModel.fromJson(json['openSinusLift_Membrane_Company']) : null;
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
    date = DateTime.tryParse(json['date']??"")?.toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestChanges'] = this.requestChanges==null?null: (this.requestChanges!.map((e) => RequestChangeModel.fromEntity(e).toJson()).toList());
    data['surgicalTreatment'] = (this.surgicalTreatment ?? []).map((e) =>TeethTreatmentPlanModel.fromEntity(e).toJson()).toList();
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
    data['date'] = this.date==null?null:this.date!.toUtc().toIso8601String();
    return data;
  }

}
