import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/trearmentPlanPropertyEntity.dart';
import 'package:equatable/equatable.dart';

class TeethTreatmentPlanEntity extends Equatable {
  int? id;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  int? tooth;
  TreatmentPlanPropertyEntity? rootCanalTreatment;
  TreatmentPlanPropertyEntity? restoration;
  TreatmentPlanPropertyEntity? pontic;
  TreatmentPlanPropertyEntity? extraction;
  TreatmentPlanPropertyEntity? simpleImplant;
  TreatmentPlanPropertyEntity? immediateImplant;
  TreatmentPlanPropertyEntity? expansionWithImplant;
  TreatmentPlanPropertyEntity? splittingWithImplant;
  TreatmentPlanPropertyEntity? gbrWithImplant;
  TreatmentPlanPropertyEntity? openSinusWithImplant;
  TreatmentPlanPropertyEntity? closedSinusWithImplant;
  TreatmentPlanPropertyEntity? guidedImplant;
  TreatmentPlanPropertyEntity? expansionWithoutImplant;
  TreatmentPlanPropertyEntity? splittingWithoutImplant;
  TreatmentPlanPropertyEntity? gbrWithoutImplant;
  TreatmentPlanPropertyEntity? openSinusWithoutImplant;
  TreatmentPlanPropertyEntity? closedSinusWithoutImplant;
  TreatmentPlanPropertyEntity? scaling;
  TreatmentPlanPropertyEntity? crown;

  TeethTreatmentPlanEntity({
    this.id,
    this.patientId,
    this.patient,
    this.tooth,
    this.rootCanalTreatment,
    this.restoration,
    this.pontic,
    this.extraction,
    this.simpleImplant,
    this.immediateImplant,
    this.expansionWithImplant,
    this.splittingWithImplant,
    this.gbrWithImplant,
    this.openSinusWithImplant,
    this.closedSinusWithImplant,
    this.guidedImplant,
    this.expansionWithoutImplant,
    this.splittingWithoutImplant,
    this.gbrWithoutImplant,
    this.openSinusWithoutImplant,
    this.closedSinusWithoutImplant,
    this.scaling,
    this.crown,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
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
      ];

  bool isNull() =>
      rootCanalTreatment == null &&
      restoration == null &&
      pontic == null &&
      extraction == null &&
      simpleImplant == null &&
      immediateImplant == null &&
      expansionWithImplant == null &&
      splittingWithImplant == null &&
      gbrWithImplant == null &&
      openSinusWithImplant == null &&
      closedSinusWithImplant == null &&
      guidedImplant == null &&
      expansionWithoutImplant == null &&
      splittingWithoutImplant == null &&
      gbrWithoutImplant == null &&
      openSinusWithoutImplant == null &&
      closedSinusWithoutImplant == null &&
      scaling == null &&
      crown == null;
}
