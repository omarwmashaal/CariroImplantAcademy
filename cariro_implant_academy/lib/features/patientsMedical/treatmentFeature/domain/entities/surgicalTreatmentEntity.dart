
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:equatable/equatable.dart';

class SurgicalTreatmentEntity extends Equatable{
  int? id;
  int? patientId;
  BasicNameIdObjectEntity? doctor;
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
  MembraneEntity? openSinusLift_Membrane;
  int? openSinusLift_Membrane_CompanyID;
  BasicNameIdObjectEntity? openSinusLift_Membrane_Company;
  int? openSinusLiftTacsNumber;
  int? openSinusLift_TacsCompanyID;
  TacCompanyEntity? openSinusLift_TacsCompany;
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
  List<TeethTreatmentPlanEntity>? surgicalTreatment;

  SurgicalTreatmentEntity(
      {this.id,
        this.patientId,
        this.doctor,
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

  @override
  List<Object?> get props => [
    id,
    patientId,
    doctor,
    guidedBoneRegeneration ,
    guidedBoneRegenerationBlockGraft ,
    guidedBoneRegenerationBlockGraftChin ,
    guidedBoneRegenerationBlockGraftRamus ,
    guidedBoneRegenerationBlockGraftTuberosity ,
    guidedBoneRegenerationBlockGraftOther,
    guidedBoneRegenerationCutBy ,
    guidedBoneRegenerationCutByDisc ,
    guidedBoneRegenerationCutByPiezo ,
    guidedBoneRegenerationCutByScrews ,
    guidedBoneRegenerationCutByScrewsNumber,
    guidedBoneRegenerationBoneParticle ,
    guidedBoneRegenerationBoneParticle100Autogenous ,
    guidedBoneRegenerationBoneParticle100Xenograft ,
    guidedBoneRegenerationACMBur ,
    guidedBoneRegenerationACMBurArea,
    guidedBoneRegenerationACMBurNotes,
    openSinusLift ,
    openSinusLiftApproach ,
    openSinusLiftApproachString,
    openSinusLiftFillMaterial ,
    openSinusLiftFillMaterialString,
    openSinusLift_MembraneID,
    openSinusLift_Membrane,
    openSinusLift_Membrane_CompanyID,
    openSinusLift_Membrane_Company,
    openSinusLift_TacsCompany,
    openSinusLift_TacsCompanyID,
    openSinusLiftTacsNumber,
    softTissueGraft ,
    softTissueGraftSurgeryType ,
    softTissueGraftSurgeryTypeSoftTissueGraft ,
    softTissueGraftSurgeryTypeAdvanced ,
    softTissueGraftSurgeryTypeFreeGinivalGraft ,
    softTissueGraftSurgeryTypeConnectiveTissueGraft ,
    softTissueGraftSurgeryTypeSurgeryTechnique,
    softTissueGraftExposure ,
    softTissueGraftExposureCustomizedHealingCollarTeethNumber,
    softTissueGraftDonorSite ,
    softTissueGraftDonorSiteNotes,
    softTissueGraftSuture ,
    softTissueGraftSutureMaterial,
    softTissueGraftSutureTechnique,
    softTissueGraftSuturePackType,
    softTissueGraftRecipientSite ,
    softTissueGraftRecipientSiteArea,
    softTissueGraftAugmentation ,
    softTissueGraftAugmentationBuccal ,
    softTissueGraftAugmentationCrestal ,
    softTissueGraftAugmentationLingual ,
    softTissueGraftAugmentationMesial ,
    softTissueGraftAugmentationDistal ,
    softTissueGraftFrenectomy ,
    softTissueGraftFrenectomyNotes,
    softTissueGraftBoneGraft ,
    softTissueGraftBoneGraftNotes,
    sutureAndTemporizationAndXRay ,
    sutureAndTemporizationAndXRaySutureSize ,
    sutureAndTemporizationAndXRaySutureSize30 ,
    sutureAndTemporizationAndXRaySutureSize40 ,
    sutureAndTemporizationAndXRaySutureSize50 ,
    sutureAndTemporizationAndXRaySutureSize60 ,
    sutureAndTemporizationAndXRaySutureSize70 ,
    sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal ,
    sutureAndTemporizationAndXRayMaterial ,
    sutureAndTemporizationAndXRayMaterialVicryl ,
    sutureAndTemporizationAndXRayMaterialProline ,
    sutureAndTemporizationAndXRayMaterialXRay ,
    sutureAndTemporizationAndXRayMaterialSutureTechnique,
    sutureAndTemporizationAndXRayTemporary ,
    sutureAndTemporizationAndXRayTemporaryHealingCollar ,
    sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar ,
    sutureAndTemporizationAndXRayTemporaryCrown ,
    sutureAndTemporizationAndXRayTemporaryMarylandBridge ,
    sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth ,
    sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber ,
    date,
    surgicalTreatment,
  ];



}
