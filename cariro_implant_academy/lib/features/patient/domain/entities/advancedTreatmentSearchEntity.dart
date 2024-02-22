import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';

import '../../../patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';

class AdvancedTreatmentSearchEntity extends Equatable {
  List<int>? ids;
  int? id;
  int? tooth;
  String? secondaryId;
  String? patientName;
  bool? noTreatmentPlan;
  bool? done;
  bool? scaling;
  bool? crown;
  bool? rootCanalTreatment;
  bool? restoration;
  bool? pontic;
  bool? extraction;
  bool? simpleImplant;
  bool? immediateImplant;
  bool? expansionWithImplant;
  bool? splittingWithImplant;
  bool? gbrWithImplant;
  bool? openSinusWithImplant;
  bool? closedSinusWithImplant;
  bool? guidedImplant;
  bool? expansionWithoutImplant;
  bool? splittingWithoutImplant;
  bool? gbrWithoutImplant;
  bool? openSinusWithoutImplant;
  bool? closedSinusWithoutImplant;

  bool? and_scaling;
  bool? and_crown;
  bool? and_rootCanalTreatment;
  bool? and_restoration;
  bool? and_pontic;
  bool? and_extraction;
  bool? and_simpleImplant;
  bool? and_immediateImplant;
  bool? and_expansionWithImplant;
  bool? and_splittingWithImplant;
  bool? and_gbrWithImplant;
  bool? and_openSinusWithImplant;
  bool? and_closedSinusWithImplant;
  bool? and_guidedImplant;
  bool? and_expansionWithoutImplant;
  bool? and_splittingWithoutImplant;
  bool? and_gbrWithoutImplant;
  bool? and_openSinusWithoutImplant;
  bool? and_closedSinusWithoutImplant;
  bool? implantFailed;
  ComplicationsAfterSurgeryEntity? complicationsAfterSurgery;
  ComplicationsAfterSurgeryEntity? complicationsAfterSurgeryOr;
  String? str_complicationsAfterSurgery;
  String? str_complicationsAfterProsthesis;

  String? str_scaling;
  String? str_crown;
  String? str_rootCanalTreatment;
  String? str_restoration;
  String? str_pontic;
  String? str_extraction;
  String? str_simpleImplant;
  String? str_immediateImplant;
  String? str_expansionWithImplant;
  String? str_splittingWithImplant;
  String? str_gbrWithImplant;
  String? str_openSinusWithImplant;
  String? str_closedSinusWithImplant;
  String? str_guidedImplant;
  String? str_expansionWithoutImplant;
  String? str_splittingWithoutImplant;
  String? str_gbrWithoutImplant;
  String? str_openSinusWithoutImplant;
  String? str_closedSinusWithoutImplant;
  String? str_implantFailed;
  EnumTeethClassification? teethClassification;

  AdvancedTreatmentSearchEntity({
    this.id,
    this.ids,
    this.secondaryId,
    this.tooth,
    this.complicationsAfterSurgeryOr,
    this.patientName,
    this.done,
    this.scaling,
    this.crown,
    this.rootCanalTreatment,
    this.restoration,
    this.pontic,
    this.extraction,
    this.simpleImplant,
    this.immediateImplant,
    this.expansionWithImplant,
    this.splittingWithImplant,
    this.gbrWithImplant,
    this.implantFailed,
    this.complicationsAfterSurgery,
    this.openSinusWithImplant,
    this.closedSinusWithImplant,
    this.guidedImplant,
    this.expansionWithoutImplant,
    this.splittingWithoutImplant,
    this.gbrWithoutImplant,
    this.openSinusWithoutImplant,
    this.closedSinusWithoutImplant,
    this.noTreatmentPlan,
    this.str_scaling,
    this.str_crown,
    this.str_rootCanalTreatment,
    this.str_restoration,
    this.str_pontic,
    this.str_extraction,
    this.str_simpleImplant,
    this.str_immediateImplant,
    this.str_expansionWithImplant,
    this.str_splittingWithImplant,
    this.str_gbrWithImplant,
    this.str_complicationsAfterSurgery,
    this.str_complicationsAfterProsthesis,
    this.str_implantFailed,
    this.str_openSinusWithImplant,
    this.str_closedSinusWithImplant,
    this.str_guidedImplant,
    this.str_expansionWithoutImplant,
    this.str_splittingWithoutImplant,
    this.str_gbrWithoutImplant,
    this.str_openSinusWithoutImplant,
    this.str_closedSinusWithoutImplant,
    this.and_scaling,
    this.and_crown,
    this.and_rootCanalTreatment,
    this.and_restoration,
    this.and_pontic,
    this.and_extraction,
    this.and_simpleImplant,
    this.and_immediateImplant,
    this.and_expansionWithImplant,
    this.and_splittingWithImplant,
    this.and_gbrWithImplant,
    this.and_openSinusWithImplant,
    this.and_closedSinusWithImplant,
    this.and_guidedImplant,
    this.and_expansionWithoutImplant,
    this.and_splittingWithoutImplant,
    this.and_gbrWithoutImplant,
    this.and_openSinusWithoutImplant,
    this.and_closedSinusWithoutImplant,
    this.teethClassification,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.tooth,
        this.complicationsAfterSurgeryOr,
        this.secondaryId,
        this.implantFailed,
        this.complicationsAfterSurgery,
        this.patientName,
        this.done,
        this.scaling,
        this.crown,
        this.rootCanalTreatment,
        this.restoration,
        this.ids,
        this.pontic,
        this.noTreatmentPlan,
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
        this.str_scaling,
        this.str_crown,
        this.str_rootCanalTreatment,
        this.str_restoration,
        this.str_pontic,
        this.str_extraction,
        this.str_simpleImplant,
        this.str_immediateImplant,
        this.str_expansionWithImplant,
        this.str_splittingWithImplant,
        this.str_gbrWithImplant,
        this.str_openSinusWithImplant,
        this.str_closedSinusWithImplant,
        this.str_guidedImplant,
        this.str_expansionWithoutImplant,
        this.str_splittingWithoutImplant,
        this.str_gbrWithoutImplant,
        this.str_openSinusWithoutImplant,
        this.str_closedSinusWithoutImplant,
        this.teethClassification,
        this.and_scaling,
        this.and_crown,
        this.and_rootCanalTreatment,
        this.and_restoration,
        this.and_pontic,
        this.and_extraction,
        this.and_simpleImplant,
        this.and_immediateImplant,
        this.and_expansionWithImplant,
        this.and_splittingWithImplant,
        this.str_implantFailed,
        this.and_gbrWithImplant,
        this.and_openSinusWithImplant,
        this.and_closedSinusWithImplant,
        this.and_guidedImplant,
        this.and_expansionWithoutImplant,
        this.and_splittingWithoutImplant,
        this.and_gbrWithoutImplant,
        this.and_openSinusWithoutImplant,
        this.and_closedSinusWithoutImplant,
        this.str_complicationsAfterSurgery,
        this.str_complicationsAfterProsthesis,
      ];

  bool isNull() =>
      and_scaling == null &&
      and_crown == null &&
      and_rootCanalTreatment == null &&
      and_restoration == null &&
      and_pontic == null &&
      and_extraction == null &&
      and_simpleImplant == null &&
      and_immediateImplant == null &&
      and_expansionWithImplant == null &&
      and_splittingWithImplant == null &&
      and_gbrWithImplant == null &&
      and_openSinusWithImplant == null &&
      and_closedSinusWithImplant == null &&
      and_guidedImplant == null &&
      and_expansionWithoutImplant == null &&
      and_splittingWithoutImplant == null &&
      and_gbrWithoutImplant == null &&
      and_openSinusWithoutImplant == null &&
      and_closedSinusWithoutImplant == null &&
      pontic == null &&
      noTreatmentPlan == null &&
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
      crown == null &&
      rootCanalTreatment == null &&
      restoration == null;

  AdvancedTreatmentSearchEntity copyWith({
    ValueGetter<List<int>?>? ids,
    ValueGetter<int?>? id,
    ValueGetter<int?>? tooth,
    ValueGetter<String?>? secondaryId,
    ValueGetter<String?>? patientName,
    ValueGetter<bool?>? noTreatmentPlan,
    ValueGetter<bool?>? done,
    ValueGetter<bool?>? scaling,
    ValueGetter<bool?>? crown,
    ValueGetter<bool?>? rootCanalTreatment,
    ValueGetter<bool?>? restoration,
    ValueGetter<bool?>? pontic,
    ValueGetter<bool?>? extraction,
    ValueGetter<bool?>? simpleImplant,
    ValueGetter<bool?>? immediateImplant,
    ValueGetter<bool?>? expansionWithImplant,
    ValueGetter<bool?>? splittingWithImplant,
    ValueGetter<bool?>? gbrWithImplant,
    ValueGetter<bool?>? openSinusWithImplant,
    ValueGetter<bool?>? closedSinusWithImplant,
    ValueGetter<bool?>? guidedImplant,
    ValueGetter<bool?>? expansionWithoutImplant,
    ValueGetter<bool?>? splittingWithoutImplant,
    ValueGetter<bool?>? gbrWithoutImplant,
    ValueGetter<bool?>? openSinusWithoutImplant,
    ValueGetter<bool?>? closedSinusWithoutImplant,
    ValueGetter<bool?>? and_scaling,
    ValueGetter<bool?>? and_crown,
    ValueGetter<bool?>? and_rootCanalTreatment,
    ValueGetter<bool?>? and_restoration,
    ValueGetter<bool?>? and_pontic,
    ValueGetter<bool?>? and_extraction,
    ValueGetter<bool?>? and_simpleImplant,
    ValueGetter<bool?>? and_immediateImplant,
    ValueGetter<bool?>? and_expansionWithImplant,
    ValueGetter<bool?>? and_splittingWithImplant,
    ValueGetter<bool?>? and_gbrWithImplant,
    ValueGetter<bool?>? and_openSinusWithImplant,
    ValueGetter<bool?>? and_closedSinusWithImplant,
    ValueGetter<bool?>? and_guidedImplant,
    ValueGetter<bool?>? and_expansionWithoutImplant,
    ValueGetter<bool?>? and_splittingWithoutImplant,
    ValueGetter<bool?>? and_gbrWithoutImplant,
    ValueGetter<bool?>? and_openSinusWithoutImplant,
    ValueGetter<bool?>? and_closedSinusWithoutImplant,
    ValueGetter<bool?>? implantFailed,
    ValueGetter<ComplicationsAfterProsthesisEntity?>? complicationsAfterProsthesis,
    ValueGetter<ComplicationsAfterProsthesisEntity?>? complicationsAfterProsthesisOr,
    ValueGetter<ComplicationsAfterSurgeryEntity?>? complicationsAfterSurgery,
    ValueGetter<ComplicationsAfterSurgeryEntity?>? complicationsAfterSurgeryOr,
    ValueGetter<String?>? str_complicationsAfterSurgery,
    ValueGetter<String?>? str_complicationsAfterProsthesis,
    ValueGetter<String?>? str_scaling,
    ValueGetter<String?>? str_crown,
    ValueGetter<String?>? str_rootCanalTreatment,
    ValueGetter<String?>? str_restoration,
    ValueGetter<String?>? str_pontic,
    ValueGetter<String?>? str_extraction,
    ValueGetter<String?>? str_simpleImplant,
    ValueGetter<String?>? str_immediateImplant,
    ValueGetter<String?>? str_expansionWithImplant,
    ValueGetter<String?>? str_splittingWithImplant,
    ValueGetter<String?>? str_gbrWithImplant,
    ValueGetter<String?>? str_openSinusWithImplant,
    ValueGetter<String?>? str_closedSinusWithImplant,
    ValueGetter<String?>? str_guidedImplant,
    ValueGetter<String?>? str_expansionWithoutImplant,
    ValueGetter<String?>? str_splittingWithoutImplant,
    ValueGetter<String?>? str_gbrWithoutImplant,
    ValueGetter<String?>? str_openSinusWithoutImplant,
    ValueGetter<String?>? str_closedSinusWithoutImplant,
    ValueGetter<String?>? str_implantFailed,
    ValueGetter<EnumTeethClassification?>? teethClassification,
  }) {
    return AdvancedTreatmentSearchEntity(
      ids: ids != null ? ids() : this.ids,
      id: id != null ? id() : this.id,
      tooth: tooth != null ? tooth() : this.tooth,
      secondaryId: secondaryId != null ? secondaryId() : this.secondaryId,
      patientName: patientName != null ? patientName() : this.patientName,
      noTreatmentPlan: noTreatmentPlan != null ? noTreatmentPlan() : this.noTreatmentPlan,
      done: done != null ? done() : this.done,
      scaling: scaling != null ? scaling() : this.scaling,
      crown: crown != null ? crown() : this.crown,
      rootCanalTreatment: rootCanalTreatment != null ? rootCanalTreatment() : this.rootCanalTreatment,
      restoration: restoration != null ? restoration() : this.restoration,
      pontic: pontic != null ? pontic() : this.pontic,
      extraction: extraction != null ? extraction() : this.extraction,
      simpleImplant: simpleImplant != null ? simpleImplant() : this.simpleImplant,
      immediateImplant: immediateImplant != null ? immediateImplant() : this.immediateImplant,
      expansionWithImplant: expansionWithImplant != null ? expansionWithImplant() : this.expansionWithImplant,
      splittingWithImplant: splittingWithImplant != null ? splittingWithImplant() : this.splittingWithImplant,
      gbrWithImplant: gbrWithImplant != null ? gbrWithImplant() : this.gbrWithImplant,
      openSinusWithImplant: openSinusWithImplant != null ? openSinusWithImplant() : this.openSinusWithImplant,
      closedSinusWithImplant: closedSinusWithImplant != null ? closedSinusWithImplant() : this.closedSinusWithImplant,
      guidedImplant: guidedImplant != null ? guidedImplant() : this.guidedImplant,
      expansionWithoutImplant: expansionWithoutImplant != null ? expansionWithoutImplant() : this.expansionWithoutImplant,
      splittingWithoutImplant: splittingWithoutImplant != null ? splittingWithoutImplant() : this.splittingWithoutImplant,
      gbrWithoutImplant: gbrWithoutImplant != null ? gbrWithoutImplant() : this.gbrWithoutImplant,
      openSinusWithoutImplant: openSinusWithoutImplant != null ? openSinusWithoutImplant() : this.openSinusWithoutImplant,
      closedSinusWithoutImplant: closedSinusWithoutImplant != null ? closedSinusWithoutImplant() : this.closedSinusWithoutImplant,
      and_scaling: and_scaling != null ? and_scaling() : this.and_scaling,
      and_crown: and_crown != null ? and_crown() : this.and_crown,
      and_rootCanalTreatment: and_rootCanalTreatment != null ? and_rootCanalTreatment() : this.and_rootCanalTreatment,
      and_restoration: and_restoration != null ? and_restoration() : this.and_restoration,
      and_pontic: and_pontic != null ? and_pontic() : this.and_pontic,
      and_extraction: and_extraction != null ? and_extraction() : this.and_extraction,
      and_simpleImplant: and_simpleImplant != null ? and_simpleImplant() : this.and_simpleImplant,
      and_immediateImplant: and_immediateImplant != null ? and_immediateImplant() : this.and_immediateImplant,
      and_expansionWithImplant: and_expansionWithImplant != null ? and_expansionWithImplant() : this.and_expansionWithImplant,
      and_splittingWithImplant: and_splittingWithImplant != null ? and_splittingWithImplant() : this.and_splittingWithImplant,
      and_gbrWithImplant: and_gbrWithImplant != null ? and_gbrWithImplant() : this.and_gbrWithImplant,
      and_openSinusWithImplant: and_openSinusWithImplant != null ? and_openSinusWithImplant() : this.and_openSinusWithImplant,
      and_closedSinusWithImplant: and_closedSinusWithImplant != null ? and_closedSinusWithImplant() : this.and_closedSinusWithImplant,
      and_guidedImplant: and_guidedImplant != null ? and_guidedImplant() : this.and_guidedImplant,
      and_expansionWithoutImplant: and_expansionWithoutImplant != null ? and_expansionWithoutImplant() : this.and_expansionWithoutImplant,
      and_splittingWithoutImplant: and_splittingWithoutImplant != null ? and_splittingWithoutImplant() : this.and_splittingWithoutImplant,
      and_gbrWithoutImplant: and_gbrWithoutImplant != null ? and_gbrWithoutImplant() : this.and_gbrWithoutImplant,
      and_openSinusWithoutImplant: and_openSinusWithoutImplant != null ? and_openSinusWithoutImplant() : this.and_openSinusWithoutImplant,
      and_closedSinusWithoutImplant: and_closedSinusWithoutImplant != null ? and_closedSinusWithoutImplant() : this.and_closedSinusWithoutImplant,
      implantFailed: implantFailed != null ? implantFailed() : this.implantFailed,
      complicationsAfterSurgery: complicationsAfterSurgery != null ? complicationsAfterSurgery() : this.complicationsAfterSurgery,
      complicationsAfterSurgeryOr: complicationsAfterSurgeryOr != null ? complicationsAfterSurgeryOr() : this.complicationsAfterSurgeryOr,
      str_complicationsAfterSurgery: str_complicationsAfterSurgery != null ? str_complicationsAfterSurgery() : this.str_complicationsAfterSurgery,
      str_complicationsAfterProsthesis:
          str_complicationsAfterProsthesis != null ? str_complicationsAfterProsthesis() : this.str_complicationsAfterProsthesis,
      str_scaling: str_scaling != null ? str_scaling() : this.str_scaling,
      str_crown: str_crown != null ? str_crown() : this.str_crown,
      str_rootCanalTreatment: str_rootCanalTreatment != null ? str_rootCanalTreatment() : this.str_rootCanalTreatment,
      str_restoration: str_restoration != null ? str_restoration() : this.str_restoration,
      str_pontic: str_pontic != null ? str_pontic() : this.str_pontic,
      str_extraction: str_extraction != null ? str_extraction() : this.str_extraction,
      str_simpleImplant: str_simpleImplant != null ? str_simpleImplant() : this.str_simpleImplant,
      str_immediateImplant: str_immediateImplant != null ? str_immediateImplant() : this.str_immediateImplant,
      str_expansionWithImplant: str_expansionWithImplant != null ? str_expansionWithImplant() : this.str_expansionWithImplant,
      str_splittingWithImplant: str_splittingWithImplant != null ? str_splittingWithImplant() : this.str_splittingWithImplant,
      str_gbrWithImplant: str_gbrWithImplant != null ? str_gbrWithImplant() : this.str_gbrWithImplant,
      str_openSinusWithImplant: str_openSinusWithImplant != null ? str_openSinusWithImplant() : this.str_openSinusWithImplant,
      str_closedSinusWithImplant: str_closedSinusWithImplant != null ? str_closedSinusWithImplant() : this.str_closedSinusWithImplant,
      str_guidedImplant: str_guidedImplant != null ? str_guidedImplant() : this.str_guidedImplant,
      str_expansionWithoutImplant: str_expansionWithoutImplant != null ? str_expansionWithoutImplant() : this.str_expansionWithoutImplant,
      str_splittingWithoutImplant: str_splittingWithoutImplant != null ? str_splittingWithoutImplant() : this.str_splittingWithoutImplant,
      str_gbrWithoutImplant: str_gbrWithoutImplant != null ? str_gbrWithoutImplant() : this.str_gbrWithoutImplant,
      str_openSinusWithoutImplant: str_openSinusWithoutImplant != null ? str_openSinusWithoutImplant() : this.str_openSinusWithoutImplant,
      str_closedSinusWithoutImplant: str_closedSinusWithoutImplant != null ? str_closedSinusWithoutImplant() : this.str_closedSinusWithoutImplant,
      str_implantFailed: str_implantFailed != null ? str_implantFailed() : this.str_implantFailed,
      teethClassification: teethClassification != null ? teethClassification() : this.teethClassification,
    );
  }
}
